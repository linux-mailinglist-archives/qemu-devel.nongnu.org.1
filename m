Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D4F7C56B4
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 16:23:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqa6q-00067o-TI; Wed, 11 Oct 2023 10:22:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqa6o-00066q-Gv
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:22:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqa6n-0002DP-4j
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:22:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697034161;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=JHQTj+e/m4pN2NxcRHhlGcfrjKXhjL5UaW3MuuDPaac=;
 b=QKKP7M/1Qvsr8CLvSOnv9WMu3sWG7yjVwKTIQwMJLGfQUWTmCy0kK2lI/GxqNiA+gEXsr2
 Lrld5xp00wypo9HKR6IsXvEY9hXeQ2BEIGBxSinY2d8v1NMspwxQn38e7CzcKVa14wwGKl
 cmWd2yBXQxSAbJ9GbIMjdqgM4MQhugQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-W52DDMNKN6yeMynQNLUiDg-1; Wed, 11 Oct 2023 10:22:39 -0400
X-MC-Unique: W52DDMNKN6yeMynQNLUiDg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-40570ccc497so51571615e9.3
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 07:22:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697034158; x=1697638958;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JHQTj+e/m4pN2NxcRHhlGcfrjKXhjL5UaW3MuuDPaac=;
 b=lhdH1N8Fj6f5x7J/96kfzxDa+BAWEuWJ/8iQSuISjldewcCREef13Y8pTlWn9dFkrC
 J8xpf+2k9bsEVbWmGVfG5oJOxMmMb6xWg0dwr18pFoQba/XC96t2ejMgmUrKfBvxW/Jk
 xe7DGzdBmgvB+E1rY3dmC49Zp3Q/zKGFTijFLIkrCAlGQG45J9YHP5X/zQSXFqunD5rU
 gasXFRbdcBDsI5JCETFgZ1LRVhftSUM7tTHU91yD2squMwjSBBM2rn2DGJxX1OxRj9a5
 vR0o7N+9Mut52DYio8jDN3hkRfnVRP6MM1ATtcpMMtDBYCG/qlOztAWbnito1CITwI/m
 qKnw==
X-Gm-Message-State: AOJu0YzyHlGF3EYlDS907E8JkBNxKD/NScfNzirwnN0zzaT5wb/GdHgd
 Cx2U4eo7vwqWHZC/Nrw8rwcSF9fwbu5j7FKsyuPiP+LYg1sBuulC+PxRpH5gphQiOj2kRl2OM5V
 LRodXZ+xqIPVMeoA=
X-Received: by 2002:a5d:4b48:0:b0:319:7a91:7107 with SMTP id
 w8-20020a5d4b48000000b003197a917107mr16993334wrs.48.1697034158297; 
 Wed, 11 Oct 2023 07:22:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4Zf+11LvJEmHQW2xEco/FYT49HMSzy71GEInCmeSqyaVy93cQ3LwrqsAYA0StLmhAH7Reyw==
X-Received: by 2002:a5d:4b48:0:b0:319:7a91:7107 with SMTP id
 w8-20020a5d4b48000000b003197a917107mr16993300wrs.48.1697034157669; 
 Wed, 11 Oct 2023 07:22:37 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 c16-20020a5d4f10000000b00324ae863ac1sm15666749wru.35.2023.10.11.07.22.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 07:22:37 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Daniel
 P . =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Alex =?utf-8?Q?Benn?=
 =?utf-8?Q?=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,  Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 4/9] tests/qtest: Introduce qtest_has_machine_with_env
In-Reply-To: <20231006123910.17759-5-farosas@suse.de> (Fabiano Rosas's message
 of "Fri, 6 Oct 2023 09:39:05 -0300")
References: <20231006123910.17759-1-farosas@suse.de>
 <20231006123910.17759-5-farosas@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 11 Oct 2023 16:22:36 +0200
Message-ID: <87ttqx8cib.fsf@secure.mitica>
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
> Add a variant of qtest_has_machine() that receives an environment
> variable containing an alternate QEMU binary path.
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Juan Quintela <quintela@redhat.com>


