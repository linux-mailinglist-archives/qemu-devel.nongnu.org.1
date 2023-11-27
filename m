Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C78E7FA05D
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 14:10:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7bM8-0006va-4n; Mon, 27 Nov 2023 08:08:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1r7bLx-0006v6-TV
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 08:08:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1r7bLv-0007PC-BH
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 08:08:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701090521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uN+YMVr7B6xs/+kDx1M6clvni89OI/FHCKS4UZYEppU=;
 b=PVLxkg4+kyLFTss94xpH9qI4gkKf6bMOx/6O+pxtllYjRtIutt7N37m56r5+Zo4ONd0dVA
 esggcRc/OfIyX9azL75yJR9OcpLTQYD+JhXmVhO6/zt64cFA8cbBwkTc36R73nEY15KKUT
 WszW7vBhVRGLZuL+3JMlVrou3ir4JlY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-7iEs1eDwMs6a8JpnkibrBg-1; Mon, 27 Nov 2023 08:08:39 -0500
X-MC-Unique: 7iEs1eDwMs6a8JpnkibrBg-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-67a3773e271so16791766d6.3
 for <qemu-devel@nongnu.org>; Mon, 27 Nov 2023 05:08:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701090519; x=1701695319;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uN+YMVr7B6xs/+kDx1M6clvni89OI/FHCKS4UZYEppU=;
 b=bRVui+O/2UYE2ppS2t6ZCmqBVsxJqvVkB7ml1fwDEtIvrZzIdV4OUppc0yTKL2DUn6
 SQwqb0lGsQBwIfM7PFq9d4uKC+dMMor7vB/7hnZXJQvCXJHKgUzYv/xY9pjYAqAl68LY
 C4yekaDzkXtzYblhats3bGdZ2ZPywKDW2BYL3POe2+R6CfTyObUygIi2ye3pm1sAdpTx
 Tm7MfqYnl81O52Ou3QX2eeFSZJidNfvbrz+PdrxPgE10HnGFeM0vCg8Z+TW3VbpL6L4s
 NI7ULexLgefidiBI+G9tSO/j8H+RPXsfWlTlssNEX6wyMR0S75jhXsyFKZG0NGlEGMBL
 99bw==
X-Gm-Message-State: AOJu0YwkvP0PqfLTHXYQRFSaII//EBfuU5grWfFNjo+9E9hv/AZcmUl0
 0wNfV/31TG/kSuuoK4jAKk9S6PwNbC1EhHneg/ZOudSLaKJX4zbN88jMZgxIqDPCvNotvgX6BBI
 yA54Ejlw4GzPItmQ=
X-Received: by 2002:ad4:418e:0:b0:67a:3388:a878 with SMTP id
 e14-20020ad4418e000000b0067a3388a878mr6142224qvp.14.1701090519172; 
 Mon, 27 Nov 2023 05:08:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHRX3eUKo+CxOW4/FahA244oj0ubXrAnQ2dIRrVcE6+rEIR0UeDX44t+pU5ClX4pGqFKo1tBg==
X-Received: by 2002:ad4:418e:0:b0:67a:3388:a878 with SMTP id
 e14-20020ad4418e000000b0067a3388a878mr6142208qvp.14.1701090518928; 
 Mon, 27 Nov 2023 05:08:38 -0800 (PST)
Received: from rh (p200300c93f306f0016d68197cd5f6027.dip0.t-ipconnect.de.
 [2003:c9:3f30:6f00:16d6:8197:cd5f:6027])
 by smtp.gmail.com with ESMTPSA id
 ph25-20020a0562144a5900b0067a18544c41sm3191480qvb.58.2023.11.27.05.08.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 05:08:38 -0800 (PST)
Date: Mon, 27 Nov 2023 14:08:35 +0100 (CET)
From: Sebastian Ott <sebott@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
cc: qemu-devel@nongnu.org, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>
Subject: Re: hanging process with commit 69562648f9 ("vl: revert behaviour
 for -display none")
In-Reply-To: <CAFEAcA_F9+XDA_5_oyqqpjS+iaeOx=J05WsZ0QMB0016rUzDfw@mail.gmail.com>
Message-ID: <531d4099-747f-5ab5-8c9c-30c50e6115c8@redhat.com>
References: <392b2fb5-1747-0f73-826f-b410cdc84f07@redhat.com>
 <CAFEAcA_F9+XDA_5_oyqqpjS+iaeOx=J05WsZ0QMB0016rUzDfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, 27 Nov 2023, Peter Maydell wrote:
> On Mon, 27 Nov 2023 at 12:29, Sebastian Ott <sebott@redhat.com> wrote:
>> qemu fails to start a guest using the following command (the process just
>> hangs): qemu-system-aarch64 -machine virt -cpu host -smp 4 -m 8192
>> -kernel /boot/vmlinuz-6.7.0-rc1 -initrd ~/basic.img -append "root=/dev/ram
>> console=ttyAMA0" -enable-kvm -device virtio-gpu,hostmem=2G -display none
>>
>> ..which I've used to debug a potential virtio-gpu issue. Bisect points to
>> 69562648f9 ("vl: revert behaviour for -display none")
>
> Is it actually hanging, or is the guest starting up fine but
> outputting to a serial port which you haven't directed anywhere?

Ough, that's indeed the case. I only had a quick glance at the bt in gdb
and obviously misinterpreted what I got there.

> The commandline is a bit odd because it doesn't set up any of:
> * a serial terminal
> * a graphical window/display
> * network forwarding that would allow ssh into the guest
>
> If you add '-serial stdio' do you see the guest output?

I do. I was using the serial terminal which got setup implicitly I guess.
I'll make sure to always add this.

Sry and thanks,
Sebastian


