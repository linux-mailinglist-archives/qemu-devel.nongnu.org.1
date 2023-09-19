Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DEF7A5C47
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 10:17:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiVuB-0001A1-V1; Tue, 19 Sep 2023 04:16:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qiVtx-00019L-QB
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 04:16:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qiVtr-0007xX-T7
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 04:16:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695111362;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jeRRoItX9vBfX/oaLk8Dh551XnfCLIuXhFQq7kjb0IY=;
 b=XKDE6LBxaGDilYNE9Fva0opvwSU5iOqziCvQtOqfwEisGXcKjw6AXR72nswQwE324szEh8
 tDjGNX2CPehPmhaAYqAIeYozZiBIpSxZpsqUewPv17dVe1MYdD2uqztuJSuhtMQg9Q9RGS
 ANG11iy9UhVT3FuqsDhzzbe4kNhbH3g=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-Z12SgLTTPE2ZZcYv34hgeg-1; Tue, 19 Sep 2023 04:16:01 -0400
X-MC-Unique: Z12SgLTTPE2ZZcYv34hgeg-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-530b29ca69dso2291275a12.1
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 01:16:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695111359; x=1695716159;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jeRRoItX9vBfX/oaLk8Dh551XnfCLIuXhFQq7kjb0IY=;
 b=dN1RM0Wxe0mrqIevp73tVypWrY2teoJy0WIjYa1/lJsOLr/EcCFn69IQBdhjK2/pXU
 0BEeNvfvP3sAOm2FxAIRstiaw1d1QA6fYRuivHZigf0BBG1v2GO8eXE2Fqzx6jFEE8rD
 hgYoxrIyl8BL9rGPZliEyUOciR1xv3R/FvGcZOBV9mWt1grI28aBPMCOJT5fOu9wow7I
 zcnNmCfp2Np62U4z7lyS7YcHqdQx3La/8kU+K7eqmnHFVy0lAOU1GrIhbys+9+VAdlv+
 nkP9+xoR6p2c+DmbbSYSA6FQev/ZTXYTIQQdj2b/YsZYN54uVjfKe6u+F+/0fxuigXfL
 ftTg==
X-Gm-Message-State: AOJu0Yy/ma1iyjKnzhnG1NOxNbNYBnHqh4RIZ7eVv75S3qykF/DpGrfu
 x4NF9Z+BzlqMJ/4/slHwcF9WQpdPD3MKLY8H/UZrq/ML+6myh0x2T4uljxGtkWC3r86UwhfIWj9
 mPZSWyGYvFUBNu2n1cve/W213RRBNTnOSnJgr1ZE=
X-Received: by 2002:a17:906:3ca2:b0:9a1:e941:6f47 with SMTP id
 b2-20020a1709063ca200b009a1e9416f47mr9864989ejh.42.1695111359208; 
 Tue, 19 Sep 2023 01:15:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfmCtnzlmTlccfwKGxuSj5RyDYW4x8fdMjM3WfcWGGDgjVWeamRpaVthdArS2aNUAklrw1oQLCJDAdQR2nrrk=
X-Received: by 2002:a17:906:3ca2:b0:9a1:e941:6f47 with SMTP id
 b2-20020a1709063ca200b009a1e9416f47mr9864972ejh.42.1695111358918; Tue, 19 Sep
 2023 01:15:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230918135448.90963-1-anisinha@redhat.com>
 <CAK3XEhOMqdfyPBm0ZgkirrcaBhOwQt_eOZ7=bbdW8OJpz3hWHg@mail.gmail.com>
 <ceea0d9d-19d6-29e7-cb84-81f85936b8c2@redhat.com>
 <CAK3XEhNETZBGtzpv2vBzygQtYuzTrsihzQNRdK8kp3+_u590Rg@mail.gmail.com>
 <3a3b5c4a-afad-8362-088c-a531d6998c23@redhat.com>
 <CAK3XEhPYPaJfeK5hcq+EktSn9iFVrv05H=TJ4VJNARddK1jYOA@mail.gmail.com>
 <CAK3XEhP5dyn5bORreJSt7U_QANh2oWG2Tn9UKttbAxEKTSmEfg@mail.gmail.com>
 <CAK3XEhN-x3NdPBknpM=7ORMOdKMzRX6dMn=dY5x=ajf9+tZkSg@mail.gmail.com>
 <jy5pwwqbtciayrslmo7ecpcnd36hoqpp275qpfodcsfkjgzdfs@tvz6hggldkcc>
In-Reply-To: <jy5pwwqbtciayrslmo7ecpcnd36hoqpp275qpfodcsfkjgzdfs@tvz6hggldkcc>
From: Ani Sinha <anisinha@redhat.com>
Date: Tue, 19 Sep 2023 13:45:46 +0530
Message-ID: <CAK3XEhMijPEQVTa3zxp6ts8Z16+1i5JjyEy5MjBxNQH2HM+eKA@mail.gmail.com>
Subject: Re: [PATCH] hw/i386/pc: fix max_used_gpa for 32-bit systems
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, philmd@linaro.org, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, Sep 19, 2023 at 1:38=E2=80=AFPM Gerd Hoffmann <kraxel@redhat.com> w=
rote:
>
>   Hi,
>
> > Anything above 4 GiB is beyond 32 bits.
>
> It's not that simple.  Physical address space is 64G on processors with
> PAE support.

yeah I sent a patch previously to fix that as well.


