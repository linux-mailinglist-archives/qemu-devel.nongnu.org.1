Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 282B77C56B5
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 16:23:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqa7O-0006pF-Ro; Wed, 11 Oct 2023 10:23:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqa7M-0006oU-S5
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:23:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqa7L-0002NM-F1
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:23:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697034198;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=DR/d1C6sTEsjqKbSgholo6v7OAZAJb/nUeKQhO25S8U=;
 b=S+83Auih+r49iEhrJ6hK4SZMR4U2cohttDD66kMorQwBjevYm6IO+w+yODCxqB4MTDGH+e
 9QjgutMt6388XEKkeMuVlppiF3puczSn7k4IpLDIHuiCoTdo8CrPH/+umSxPID0WMedsxf
 7eaUjEZGIoDNFopRhyiVJFV9Y4pPObI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-pW6ix_uNOyCAd3U_PcCbwA-1; Wed, 11 Oct 2023 10:23:17 -0400
X-MC-Unique: pW6ix_uNOyCAd3U_PcCbwA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4054743df06so49368415e9.3
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 07:23:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697034196; x=1697638996;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DR/d1C6sTEsjqKbSgholo6v7OAZAJb/nUeKQhO25S8U=;
 b=l6FqyeHzyPH17Xhuouh073BUqB1VBJ88sgF5nv6pxWI1ikgUvPQJ5JU8jtV6Z2Fzcn
 GDnwUUWEGuJaAfMKfjnAWmytdWz/6Knz9/qA2f99xkerf5cfr54cr+oIaNQ3zeBe5ddV
 mH3s6E7KkZu9fAydxgwG5ao2OASiqqkDH7g8bv6oYK5XlYL1U7TBnFmoePIdFYZnKcJh
 GMh56xgyrPxDr46GBiKzrZN67izJC8ZtHppTWw4pBRC2puAHWdUpwJEmxXIIJG6ZBGlv
 eRCUII4JAfOLoiF3wZbynPeTFe5xx5ebvzJLtZcpzLhR9AyeUFw5S8yagXntkgJfqIQZ
 v4Sg==
X-Gm-Message-State: AOJu0Yzun83fLIPMvcXccXaQZAeKm+1xaXht1o+BsqZXg0EytA9kQ+KV
 EjtHmgm7qI27lw3yeXL6OatJgQeomWEHqi/zrFAYhEHeFPfpFyOcUBNTrkq/hiVl1E5dHwlq4N7
 3NZH/HqT3zfv2zns=
X-Received: by 2002:a05:600c:2a4e:b0:404:732b:674f with SMTP id
 x14-20020a05600c2a4e00b00404732b674fmr19227503wme.34.1697034196135; 
 Wed, 11 Oct 2023 07:23:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSdxzI3y/+mW3Vij9qJjXepzkEtU+IgH1VWcURkkJiiMij2ouqw/yaiiFewjsNEHuTBVKeUw==
X-Received: by 2002:a05:600c:2a4e:b0:404:732b:674f with SMTP id
 x14-20020a05600c2a4e00b00404732b674fmr19227484wme.34.1697034195901; 
 Wed, 11 Oct 2023 07:23:15 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 v16-20020a1cf710000000b003fefaf299b6sm16942197wmh.38.2023.10.11.07.23.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 07:23:15 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Daniel
 P . =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Alex =?utf-8?Q?Benn?=
 =?utf-8?Q?=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,  Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 5/9] tests/qtest: Introduce qtest_resolve_machine_alias
In-Reply-To: <20231006123910.17759-6-farosas@suse.de> (Fabiano Rosas's message
 of "Fri, 6 Oct 2023 09:39:06 -0300")
References: <20231006123910.17759-1-farosas@suse.de>
 <20231006123910.17759-6-farosas@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 11 Oct 2023 16:23:14 +0200
Message-ID: <87pm1l8ch9.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Fabiano Rosas <farosas@suse.de> wrote:
> The migration tests are being enhanced to test migration between
> different QEMU versions. A requirement of migration is that the
> machine type between source and destination matches, including the
> version.
>
> We cannot hardcode machine types in the tests because those change
> with each release. QEMU provides a machine type alias that has a fixed
> name, but points to the latest machine type at each release.
>
> Add a helper to resolve the alias into the exact machine
> type. E.g. "-machine pc" resolves to "pc-i440fx-8.2"
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Juan Quintela <quintela@redhat.com>


