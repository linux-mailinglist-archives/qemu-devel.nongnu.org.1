Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3B78BCBB5
	for <lists+qemu-devel@lfdr.de>; Mon,  6 May 2024 12:15:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3vM1-0004jU-Cs; Mon, 06 May 2024 06:13:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3vLz-0004jH-Ld
 for qemu-devel@nongnu.org; Mon, 06 May 2024 06:13:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3vLx-0000cv-SU
 for qemu-devel@nongnu.org; Mon, 06 May 2024 06:13:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714990428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
 bh=1i/nouFZzZKxXWfOben7joELYCeg9MZYcxbD/HWOVZ4=;
 b=SAme+sPLQCFrmAOsq6Z4Z4jq0VdUhKcRRMelMydeiC0rPgopTNpmuo2Xd3gSG8hDVsguGm
 uT8iXcWgyrazd54UcLxounkNRfJJK3TzyEK36ETD60Sg5N+/u/xEHv08+D65Cb4onnNaYL
 UawoPePIg6FMq5Al2ccPk4GoEaL/8js=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-sbqQ5lGkMg6Np-HLItGLjQ-1; Mon, 06 May 2024 06:13:47 -0400
X-MC-Unique: sbqQ5lGkMg6Np-HLItGLjQ-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-572afd6e96fso436191a12.2
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 03:13:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714990425; x=1715595225;
 h=content-transfer-encoding:autocrypt:subject:to:from
 :content-language:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1i/nouFZzZKxXWfOben7joELYCeg9MZYcxbD/HWOVZ4=;
 b=R4wlWRWdjv+8t7AwLHVxSTs5WbVe+ygGDPLbUFhtH7jCbNFUJrzJqn5Tm8Vxlj7TnF
 vQXKv6+Tw8+uVC/UMB9cYB1Wn2TeM6wzQsFc0ZXTBg9XAlhFwXLI7vPXuQzxkFvRG54X
 UR6lrxl8brusF+XdsYW1IuS2anS+AsWesx5v1xHrGdTuE7RFVLgbppew18Bz4U+FE4w3
 hkNvpK736ryxkfX7sK/9UimBLFYEFO7fN42WXF47MTSbKbUquQJ61O3r43YSAsyxZdD6
 gE6sW0fYiH0ADK82rY1B/olRkqtiMT7cp7UTBwBZ2QSOax4sbdCtN2Dc0yyQyeSgpoLk
 JhWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIvvagESmdLNIYeZDka8pXyNQDzAKlLtanq0VRvxgVpveBlvobiFjcaULVPu0QJrvEDuPYsprj8OeCvpTvB+Db/oBocn4=
X-Gm-Message-State: AOJu0YwScw1wTpGQv+NMY5uG3F6NCOe1+c7vhWWiWDXDu31gMzPDdIPb
 fQ4M360HDP6RwPOEupKvdmFVeLu8aZZfUpLxikogwlzFPtzHlbHKKJuLThGACgU2Ppo9h+lcZji
 +UVRJAR81otMQYQs1fLGqq300p/xMJOhb//y+v8pdNC+HYCZ7tPpYMDrAVlmK
X-Received: by 2002:a50:9982:0:b0:572:3a93:ee69 with SMTP id
 m2-20020a509982000000b005723a93ee69mr8204327edb.3.1714990425171; 
 Mon, 06 May 2024 03:13:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFz1BxSkyOLKm6fYDo4Jdflsb1KBb5EK4wob14xz47t14mtTa3w5z1LoaxaCPCXY1sB27dbGg==
X-Received: by 2002:a50:9982:0:b0:572:3a93:ee69 with SMTP id
 m2-20020a509982000000b005723a93ee69mr8204316edb.3.1714990424643; 
 Mon, 06 May 2024 03:13:44 -0700 (PDT)
Received: from [192.168.10.81] ([151.95.155.52])
 by smtp.googlemail.com with ESMTPSA id
 a9-20020aa7d749000000b005704419f56csm4976235eds.86.2024.05.06.03.13.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 May 2024 03:13:44 -0700 (PDT)
Message-ID: <115ff3b4-6ba5-4027-965b-1fd79409e6d8@redhat.com>
Date: Mon, 6 May 2024 12:13:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Paolo Bonzini <pbonzini@redhat.com>
To: KVM list <kvm@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>
Subject: Call for Presentations: KVM Forum 2024
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.431,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

###########################
KVM Forum 2024
September 22-23, 2024
Brno, Czech Republic
https://kvm-forum.qemu.org/
###########################

KVM Forum is an annual event that presents a rare opportunity for
developers and users to discuss the state of Linux virtualization
technology and plan for the challenges ahead. Sessions include updates
on the state of the KVM virtualization stack, planning for the future,
and opportunities for attendees to collaborate in "birds of a feather"
(BoF) sessions.

This year's event will be held in Brno, Czechia on September 22-23, 2024.
The location should also be easy to reach for attendees of Linux Plumbers
Conference 2024!


CALL FOR PRESENTATIONS
======================

We encourage you to submit presentations via Pretalx at
https://kvm-forum.qemu.org/2024/cfp. Suggested topics include:

* Scalability and Optimization

* Hardening and security

* Confidential computing

* Testing

* KVM and the Linux Kernel:
    * New Features and Ports
    * Device Passthrough: VFIO, mdev, vDPA
    * Network Virtualization
    * Virtio and vhost

* Virtual Machine Monitors and Management:
    * VMM Implementation: APIs, Live Migration, Performance Tuning, etc.
    * Multi-process VMMs: vhost-user, vfio-user, QEMU Storage Daemon
    * QEMU without KVM: Hypervisor.framework and other hypervisors
    * Managing KVM: Libvirt, KubeVirt, Kata Containers

* Emulation:
    * New Devices, Boards and Architectures
    * CPU Emulation and Binary Translation

All presentation slots will be 25 minutes + 5 minutes for questions.


IMPORTANT DATES
===============

The deadline for submitting presentations is June 8, 2024 - 11:59 PM CEST.

Accepted speakers will be notified on July 5, 2024.


ATTENDING KVM FORUM
===================

Admission to KVM Forum costs $75. You can get your ticket at

     https://kvm-forum.qemu.org/2024/register/

Admission is free for accepted speakers.

The conference will be held at Hotel International, which is
within walking distance from the train station:

     HOTEL INTERNATIONAL
     Husova 16
     60200 Brno-střed
     Czechia

Special room prices are available at the venue for attendees
of KVM Forum. More information will be available soon at
https://kvm-forum.qemu.org/location/.

We are committed to fostering an open and welcoming environment at our
conference. Participants are expected to abide by our code of conduct
and media policy:

     https://kvm-forum.qemu.org/coc/
     https://kvm-forum.qemu.org/media-policy/


GETTING TO BRNO
===============

Brno has a small international airport with flights from London
(Stansted) and other European cities.

Other nearby airports include Vienna, Bratislava and Prague. Travelling
to Brno is easiest from Vienna Schwechat Airport, from where there are
direct buses operated by RegioJet:

Attendees of the Linux Plumbers Conference can travel from Vienna to
Brno by train on Saturday, September 21.

If you need a visa invitation letter, please reach out to the organizers
at kvm-forum-2024-pc@redhat.com.


CONTACTS
========

Reach out to us should you have any questions. The program committee may
be contacted as a group via email: kvm-forum-2024-pc@redhat.com.


