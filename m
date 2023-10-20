Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B71A07D0A61
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 10:17:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtkgO-0000A7-J5; Fri, 20 Oct 2023 04:16:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qtkgH-00009c-PY
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 04:16:30 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qtkgF-0004df-O9
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 04:16:29 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2bfed7c4e6dso7739701fa.1
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 01:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697789784; x=1698394584; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=knfbUmDlWDNIDCvUS/vYlItD5jDiz9MwexkEaOBISbM=;
 b=xWFihcdNzgpnAVQRAq/YRbpVjFpL2psXKt76In9rETUEXCRkC7anp/H0MCXAksP2wR
 qnHjuxrdjUZPEqbkdF+bCngPQY3HDTmBN6FuxYQ+RcclOZAf+a7dEc4JVulDb2ya8R+0
 BXvKY2/hnK0NTUXigEP7oYCm0jdfQGtAEhmJo5wvcKKxY/kUeqMV+16phwCcpEhVTPBl
 gOOXQ/v28tznBwRTK0Sqob/9Ru63UXgluSVu8o3HhoE11uNhB8rlvGSViLmsU00Nbji7
 tPxayDlB2z7iNcnAWWQ0M/2uRuyRZH9LbNaYr1sUmtPGo4JZf/RfzvplP7X0Fc2gaDaw
 V4cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697789784; x=1698394584;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=knfbUmDlWDNIDCvUS/vYlItD5jDiz9MwexkEaOBISbM=;
 b=K2X0e4yCXNduMdyzpXLmbtOZ5YbsFjp7bn5t+FATPGioHv0F9Cg/jSZxPAJ94Ulsl9
 bFe25fUy/bwO74HTAaOaT8hd7MSU9jkmtHUB20k3Swu7vYecSsH8TxDNmi2NP42qHh/u
 d+Z0HNeZofboKORnZwpFgZwOoDH45rfG5qZLtUd2L0Q2BypWFpev76AEiFg7E/Rep4xe
 mfvaJlZDISgxtSHL0gwJVm3wJetYWusbKulLpljqRI2HU59f44dmzln0FVo6tYy3WcUg
 dYK0bbR0TzEt+KhN4AtS1jOv0T6MycNxwgiF7G2N/T8yCqGsvkOXqX6Osc3Wf8XSMBN/
 2wKg==
X-Gm-Message-State: AOJu0YwNKtBJ8HGvPc737+xh5y96FazjWAbD3AEL43US4bNcdNnf9oXr
 Wy7f5TmX20vC18on3VF0liKkWQ==
X-Google-Smtp-Source: AGHT+IE7JKhTrCfVtRbSiSAv7dcknPJidI0vnlSoJ1dtkriqgrA6jh+7rQOU4ksygILsgpm7H3FVBw==
X-Received: by 2002:a2e:bea1:0:b0:2c5:be8:68b1 with SMTP id
 a33-20020a2ebea1000000b002c50be868b1mr997869ljr.9.1697789784349; 
 Fri, 20 Oct 2023 01:16:24 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 m21-20020a05600c4f5500b0040841e79715sm1577978wmq.27.2023.10.20.01.16.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 01:16:24 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 738951FFBB;
 Fri, 20 Oct 2023 09:16:23 +0100 (BST)
References: <20231019095610.2818087-1-alex.bennee@linaro.org>
 <20231019095610.2818087-6-alex.bennee@linaro.org>
 <20231020031407.xd4ykc4msfdmoav5@vireshk-i7>
User-agent: mu4e 1.11.22; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 virtio-fs@redhat.com, Eduardo Habkost <eduardo@habkost.net>, Fam Zheng
 <fam@euphon.net>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Gerd
 Hoffmann <kraxel@redhat.com>, Erik Schilling <erik.schilling@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Jason Wang
 <jasowang@redhat.com>, Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, "Gonglei (Arei)"
 <arei.gonglei@huawei.com>, Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH v5 5/6] hw/virtio: add vhost-user-snd and virtio-snd-pci
 devices
Date: Fri, 20 Oct 2023 09:16:03 +0100
In-reply-to: <20231020031407.xd4ykc4msfdmoav5@vireshk-i7>
Message-ID: <878r7x90a0.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x234.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org


Viresh Kumar <viresh.kumar@linaro.org> writes:

> On 19-10-23, 10:56, Alex Benn=C3=A9e wrote:
>> From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>>=20
>> Tested with rust-vmm vhost-user-sound daemon:
>>=20
>>     RUST_LOG=3Dtrace cargo run --bin vhost-user-sound -- --socket /tmp/s=
nd.sock --backend null
>>=20
>> Invocation:
>>=20
>>     qemu-system-x86_64  \
>>             -qmp unix:./qmp-sock,server,wait=3Doff  \
>>             -m 4096 \
>>             -numa node,memdev=3Dmem \
>>             -object memory-backend-file,id=3Dmem,size=3D4G,mem-path=3D/d=
ev/shm,share=3Don \
>>             -D qemu.log \
>>             -d guest_errors,trace:\*snd\*,trace:\*sound\*,trace:\*vhost\=
* \
>>             -chardev socket,id=3Dvsnd,path=3D/tmp/snd.sock \
>>             -device vhost-user-snd-pci,chardev=3Dvsnd,id=3Dsnd \
>>             /path/to/disk
>>=20
>> [AJB: imported from https://github.com/epilys/qemu-virtio-snd/commit/54a=
e1cdd15fef2d88e9e387a175f099a38c636f4.patch]
>>=20
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> Missing SOB from Manos ?

oops, guess I need a respin then ;-)

>
>> Message-Id: <20231009095937.195728-6-alex.bennee@linaro.org>


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

