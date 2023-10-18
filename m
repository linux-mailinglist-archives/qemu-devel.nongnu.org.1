Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E05E67CE168
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 17:44:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt8h1-0007Vq-Jc; Wed, 18 Oct 2023 11:42:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qt8gt-0007KF-U9
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:42:37 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qt8gr-0004gv-Ai
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:42:35 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4083cd3917eso6442105e9.3
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 08:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697643748; x=1698248548; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RzYU5BycQP2+ljFehEBTSJxZ5LJLgOfecpXPGQ2+OLU=;
 b=moFVS4ZqU8I9GiWHh6d/5rNNki1zIGy3H5Fz8iGREBWuQddJp9BOlPzPvjBw46j6/c
 z9RxL3m6HR9TyGP8e6X2EFBIAj/zhrXl3j4iDeOd7zA85CWEHDqDsv3g954CZX/dH0rl
 Kdf3kF4a15042LqsjFvFfPSNiMupLvCLJ88qPTiZGEEqmsKT6mqi0zhd9Qt4cmFGL0Bm
 BT28nWhc4fl9TEiAIWesoj2dNgWpxFQ8tA2Edu/I8G3JglnIaIa72dpE1yqe0BQF4lHE
 s0/k3ToIHas4eYcnMN6UBszYQCBIaeCulBusOdGZryEiCKHQSzsJVkk4hqkaQDkpCXkO
 8kxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697643748; x=1698248548;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=RzYU5BycQP2+ljFehEBTSJxZ5LJLgOfecpXPGQ2+OLU=;
 b=Bx19mwamE4QyK/R4aRwVs1vTL6G6uRWyfw5xLI9pjknCP97nic25Ov0gDhBLNaArea
 t5jpQe+56mIhp3kqc/w5Udc7iA4wYSSZ469b0gPs1n6lT0pyqeOvxXBSIU5n5yug5Qzv
 3clvRo6PgI2eDkmju3Bda9NM6+EKjop3rXmGEe180QJwEhVfzODz0xu3hDhXvzGHSGeF
 L0b7BGF2vTvdV0gMwUfoe32Nl/W1xoiSmeeFjA93SoloRJ0tr3gUF5XoBA6Uxob3TLpN
 iiaMMriaRCP2tNq1NeV486zOsytFMjf3SWnogs2TsgIIUuWCW7dxC1WnJksosTr6mTv6
 VXGg==
X-Gm-Message-State: AOJu0YzwBuuGBtIa/xuEG34GyqwFTDSMQGuRqeYgxxigRRN91kcadfTi
 gTWFcjhmNZwNCR27C/fEhqQxsA==
X-Google-Smtp-Source: AGHT+IE4a14BL+d4Fq5LYq1l4Uoq5bRor9VSvliQApll7aJcAwE6zt60Xx/zM6qAroQQc2LT9RIglQ==
X-Received: by 2002:a05:600c:190c:b0:402:98cd:a3e9 with SMTP id
 j12-20020a05600c190c00b0040298cda3e9mr4468266wmq.32.1697643747873; 
 Wed, 18 Oct 2023 08:42:27 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 e7-20020a05600c218700b00407efbc4361sm1971606wme.9.2023.10.18.08.42.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 08:42:27 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E91671FFBB;
 Wed, 18 Oct 2023 16:42:26 +0100 (BST)
References: <78103368-9ea5-167b-5700-7d3d174ff564@opnsrc.net>
User-agent: mu4e 1.11.22; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Salil Mehta <salil.mehta@opnsrc.net>
Cc: "mst@redhat.com" <mst@redhat.com>, "imammedo@redhat.com >> Igor
 Mammedov" <imammedo@redhat.com>, "philmd@linaro.org" <philmd@linaro.org>,
 "david@redhat.com >> David Hildenbrand" <david@redhat.com>, Jonathan
 Cameron <jonathan.cameron@huawei.com>, Salil Mehta
 <salil.mehta@huawei.com>, qemu-devel@nongnu.org
Subject: Re: [Question] x86/microvm: why has_hotpluggable_cpus = false but
 hot(ub)plug APIs exist?
Date: Wed, 18 Oct 2023 16:41:09 +0100
In-reply-to: <78103368-9ea5-167b-5700-7d3d174ff564@opnsrc.net>
Message-ID: <87o7gw9btp.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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


Salil Mehta <salil.mehta@opnsrc.net> writes:

> Hello,
>
> Came across below code excerpt in x86/microvm code and wanted to know
> why 'has_hotpluggable_cpus' flag has been set to 'false' while various
> hot(un)plug APIs have been defined?
>
> static void microvm_class_init(ObjectClass *oc, void *data)
> {
>     X86MachineClass *x86mc =3D X86_MACHINE_CLASS(oc);
>     MachineClass *mc =3D MACHINE_CLASS(oc);
>     HotplugHandlerClass *hc =3D HOTPLUG_HANDLER_CLASS(oc);
>
>     mc->init =3D microvm_machine_state_init;
>
>     mc->family =3D "microvm_i386";
>     [...]
>     mc->max_cpus =3D 288;
>     mc->has_hotpluggable_cpus =3D false;  --------> This one
>     [...]

From the original commit that added it:

  It's a minimalist machine type without PCI nor ACPI support, designed
  for short-lived guests. microvm also establishes a baseline for
  benchmarking and optimizing both QEMU and guest operating systems,
  since it is optimized for both boot time and footprint.

Generally hotplug requires a dance between the VMM and the firmware to
properly shutdown and restart hotplug devices. The principle
communication mechanism for this is ACPI.

>
>     /* hotplug (for cpu coldplug) */
>     mc->get_hotplug_handler =3D microvm_get_hotplug_handler;
>     hc->pre_plug =3D microvm_device_pre_plug_cb;
>     hc->plug =3D microvm_device_plug_cb;
>     hc->unplug_request =3D microvm_device_unplug_request_cb;
>     hc->unplug =3D microvm_device_unplug_cb;
>     [...]
> }
>
>
> Best regards
> Salil


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

