Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0B97CC3F1
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 15:07:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsjmO-0004u9-Im; Tue, 17 Oct 2023 09:06:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsjmB-0004aT-Ko
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 09:06:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsjm8-00056a-Fp
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 09:06:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697547978;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=IviX9QNAV1My75GrtWgOXVO7PnUnUSSDfQvbPYssu9w=;
 b=jJJ3Qh8PMBWejUBGVKb18oafrAtC7XcIN8IQN1FHh1KbfAYxKJgTFekoUsfyT7WeXqV5uo
 qpwuv3QPCIJ5pwTAm+44kzUkrckuFRs5wC7DPYt6qaGNYucAqf3NmH+9arNuJ1jpc3RzgJ
 nUr2Q6ocUWQKVv6mBCMjoImaIoFBdFg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-vXzHkbroMMWQEU1G4ogpWw-1; Tue, 17 Oct 2023 09:06:16 -0400
X-MC-Unique: vXzHkbroMMWQEU1G4ogpWw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-32da47641b5so2088563f8f.0
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 06:06:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697547975; x=1698152775;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IviX9QNAV1My75GrtWgOXVO7PnUnUSSDfQvbPYssu9w=;
 b=cGNdf+f/FQw3UqnmIVYC8LYebCgprRvlK6dxo6NJFvhswtbEbOy+uDDxhsbI/3uF+A
 7fE9Bkv15oOH3pJQxuXIPtwWuIxWGGLpOdWew7TX3IJa8mG7y8zQTcVHp9LFJVWLRog8
 Qx0DmwcCD+KD2XhCjiq98KYlQbeD4xA7r3Dv+S8QShUmnKK+GUTB9ZynEM2lAIayMZU9
 bxzy4k2W6KuyTDVC5Zqp14e3IA0K6F88wCM70KMoDrUCk8suBTEysrrqFCcqz+6+HBtF
 Hz+04MMQuVD/VvtBQA7dDE9wuw+7lzTvAqevmcpqu6PfgpEkbpvFO8EqUvgUw4Xxy5pn
 8eyA==
X-Gm-Message-State: AOJu0YxRH2Fs4fAUMV2jIMYW94XX57E3jnUfCpsfSyZZkAK5TgSUxRzU
 ZOZzsF1c7keZv/5jVI8eG6Clbjdqcvf12Akq9+BH6xNHZYqbFdfbLoPZE7WoMJsmWn/EZi69xil
 IrEeHgxt1j3Sy0ro=
X-Received: by 2002:adf:e8c3:0:b0:317:dada:2417 with SMTP id
 k3-20020adfe8c3000000b00317dada2417mr2228411wrn.31.1697547975506; 
 Tue, 17 Oct 2023 06:06:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUs2M//VFUxYq8Xxko/PfUAI8i7Vqv8sLVO4Yo54aUWpwbbMRXtbWItNfNbB+NXZdcRDHfBQ==
X-Received: by 2002:adf:e8c3:0:b0:317:dada:2417 with SMTP id
 k3-20020adfe8c3000000b00317dada2417mr2228356wrn.31.1697547974532; 
 Tue, 17 Oct 2023 06:06:14 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 q6-20020a5d6586000000b00317a04131c5sm1654823wru.57.2023.10.17.06.06.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 06:06:14 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Kevin Wolf <kwolf@redhat.com>,  qemu-devel@nongnu.org,  mst@redhat.com,
 peterx@redhat.com,  leobras@redhat.com,  stefanha@redhat.com,
 pbonzini@redhat.com,  qemu-block@nongnu.org,  qemu-stable@nongnu.org
Subject: Re: [PATCH 2/2] virtio: Drop out of coroutine context in virtio_load()
In-Reply-To: <0f479df3-2563-4186-b83b-be1dc2fcae8a@tls.msk.ru> (Michael
 Tokarev's message of "Tue, 17 Oct 2023 08:19:48 +0300")
References: <20230905145002.46391-1-kwolf@redhat.com>
 <20230905145002.46391-3-kwolf@redhat.com>
 <0f479df3-2563-4186-b83b-be1dc2fcae8a@tls.msk.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Tue, 17 Oct 2023 15:06:13 +0200
Message-ID: <87lec11jqy.fsf@secure.mitica>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Michael Tokarev <mjt@tls.msk.ru> wrote:
> 05.09.2023 17:50, Kevin Wolf wrote:
>> virtio_load() as a whole should run in coroutine context because it
>> reads from the migration stream and we don't want this to block.
>> However, it calls virtio_set_features_nocheck() and devices don't
>> expect their .set_features callback to run in a coroutine and therefore
>> call functions that may not be called in coroutine context. To fix this,
>> drop out of coroutine context for calling virtio_set_features_nocheck().
> ...
>> Cc: qemu-stable@nongnu.org
>> Buglink: https://issues.redhat.com/browse/RHEL-832
>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>
> It looks like this change caused an interesting regression,
>   https://gitlab.com/qemu-project/qemu/-/issues/1933
> at least in -stable.  Can you take a look please?
>
> BTW, Kevin, do you have account @gitlab?

Dunno what is going on here, but failing postcopy is weird.

2023-10-12T06:23:44.354387Z qemu-system-x86_64: warning: TSC frequency mismatch between VM (2892749 kHz) and host (2799999 kHz), and TSC scaling unavailable 2023-10-12T06:23:44.354538Z qemu-system-x86_64: warning: TSC frequency mismatch between VM (2892749 kHz) and host (2799999 kHz), and TSC scaling unavailable

I hope/guess that the problem is not TSC related?

i.e. does other tests work between this two machines?

Once discarding that, we get on source:

2023-10-12 06:23:43.412+0000: initiating migration

2023-10-12T06:23:44.362392Z qemu-system-x86_64: failed to save
SaveStateEntry with id(name): 3(ram): -5

So migration was aborted, and -5 is EIO on my system.
So we are having trouble here with a write() somewhere.

Later, Juan.

> Thanks,
>
> /mjt


