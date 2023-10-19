Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CEA7CF860
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 14:09:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtRpW-0004if-7B; Thu, 19 Oct 2023 08:08:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtRpP-0004iA-F6
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 08:08:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtRpN-0003gh-P2
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 08:08:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697717317;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=JfW6F6pQ6bRzDsA2190i4Ym36OEwMvSTcQR4//llwpY=;
 b=J9JKbIkhOSs/t/Maqs3bAt4zV5emI/zmRcMuRfLa448BUk49lWxH4P34hNI/k6z+YIuyPa
 tyZnMZSxO/r23/mNpniXO8aGrwtVFXoMgyIOXJmKvsfpmh2IyGOsp05Mjb0RQ1bz5mfCDL
 XQG1MU8UOlbvM8GbQfU9J0YQTxqHsK4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-z9JEiv5gPh-w050CbLaipw-1; Thu, 19 Oct 2023 08:08:21 -0400
X-MC-Unique: z9JEiv5gPh-w050CbLaipw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4083865e0b7so13691995e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 05:08:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697717299; x=1698322099;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JfW6F6pQ6bRzDsA2190i4Ym36OEwMvSTcQR4//llwpY=;
 b=uqWtIhguYkw/yWABRH7xnkyTzVXccp6k54G3NPchCPDyho/oE4zAi5klivyXnDOUCV
 khODCJMeywNltUxaUW9k5tq87IYqLmD7tGlrqUjODcdp+a/bYQvzqAS2dVLnOTZQPMek
 JMT9XbyV4H8uheq6wM949GIwsYzjexPo3ptrwaKf08SRpeCIfEA13cvGbZ8XJfCE7Ydm
 HQtKy/4VFCJeecPC7yci1vBxa0KqcpKTzUY1BHyH4PypM4y+aRRYaMiRfmDdNZluTHKp
 bcbg7dSmW2gYYGXo6G2em5ylgdaNVYHxKLI2GINFcL+6oPl4L2RgGs287yhqqSJT37gp
 BlCw==
X-Gm-Message-State: AOJu0YyxWlOOQ0NGjfOj+5jNOgQXjaBPSPSwcJqETn0VlgGMBjwE+DrE
 8mX3hYBm/Vk5glVAi4j6AFLz1RhfZSKpnSNjEBWgMQfuZdiWu985bqbtvNuuYL5P2BPrbe4i2eZ
 FQfbX09T6ycQU+JnTDbsTES2ThQ==
X-Received: by 2002:a05:600c:4e93:b0:403:cab3:b763 with SMTP id
 f19-20020a05600c4e9300b00403cab3b763mr1645380wmq.33.1697717299523; 
 Thu, 19 Oct 2023 05:08:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETKyDcRil0wVj2VhRoaqBdirNkZlU13rxcxpHdmCsELQvBPSNthdHhXp3sTX6pFBCCzf8dxA==
X-Received: by 2002:a05:600c:4e93:b0:403:cab3:b763 with SMTP id
 f19-20020a05600c4e9300b00403cab3b763mr1645359wmq.33.1697717299139; 
 Thu, 19 Oct 2023 05:08:19 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 26-20020a05600c229a00b00407460234f9sm4218628wmf.21.2023.10.19.05.08.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 05:08:18 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Daniel
 P . =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Alex =?utf-8?Q?Benn?=
 =?utf-8?Q?=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v4 00/12] tests/migration-test: Allow testing older
 machine types
In-Reply-To: <20231018192741.25885-1-farosas@suse.de> (Fabiano Rosas's message
 of "Wed, 18 Oct 2023 16:27:29 -0300")
References: <20231018192741.25885-1-farosas@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Thu, 19 Oct 2023 14:08:18 +0200
Message-ID: <87edhq4xxp.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
> (please ignore v3 which was bogus, but don't miss the discussion in it
> about the caveats of this approach:
> https://lore.kernel.org/r/87jzrkdne2.fsf@suse.de)

queued for next pull request.


