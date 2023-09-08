Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A52E779893A
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 16:50:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qecn4-0003Kw-Kz; Fri, 08 Sep 2023 10:48:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qecn2-0003KX-4m
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 10:48:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qecmy-0001HQ-5x
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 10:48:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694184531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lreAMQ/8akInu5+82VtVmdGk1TMmM4mtQCq5+4qI+oM=;
 b=Ux5T2yox3zk6rPeLXxe5OdcovLds7QZB490n2A+1i8Wt5jRjGOpizRZ7XO0nOUoamXgezW
 wc8BdokGqV+r6tu6YZV8XCKpHtMAYK7IsOfBzPD1RPgFcLDD8pm++sBb8G2QNXT0DzV2pu
 2YW2i+OhkP0AckxYPSAD9wzGIvQhNfI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-A2MVnt8zOD-bIW587t7dpw-1; Fri, 08 Sep 2023 10:48:49 -0400
X-MC-Unique: A2MVnt8zOD-bIW587t7dpw-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-98e40d91fdfso149447766b.3
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 07:48:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694184528; x=1694789328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lreAMQ/8akInu5+82VtVmdGk1TMmM4mtQCq5+4qI+oM=;
 b=pfbCQE9rInG9C3and4+piYc2pcTwPqlhgFrSI2uIVDHcU2SUN0ajGx1G9/jLkobl6O
 IjPyIj7+Y9qLSFRkoJLrZe5c4w4Mn/coo0EDpXpLgUaM5LM9ne2fJd4lNvLHTxKsq8WV
 1qOWtMvcgX73s8IjgJUrTXLnL7t3y7RBr6Gz5KOLC9cUiBDFQ9dqwU5LgeuB0OvnaHor
 VZ4oPy5nAmmq/Cg72dcVtzOZVl8oFOumDKwVFUrUK193b8WGSwM6HLOKj8byYS/5r/I1
 c/wwPqO7ScOMIAY/1qIgYMWZLUw1yE03nueH/IkUnMWEzenfLLbAmuArx2/M1xC0RMoS
 QbpA==
X-Gm-Message-State: AOJu0Yxek608f45MJZ+YXTGgeOsdbUg2viSP2ZcLLiS9mNlJm3Vioz+U
 mAgM6astihntHswhkDIaxMG1nK3oI7ELt7GKRoRcT3RwmHtuoic84FN7nSew5f/WngO9WNY1qPI
 hF3XZcyF7+jCRppg=
X-Received: by 2002:a17:906:74d9:b0:9a1:d29c:6aaa with SMTP id
 z25-20020a17090674d900b009a1d29c6aaamr2079964ejl.39.1694184528618; 
 Fri, 08 Sep 2023 07:48:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDQRqBc8ERTCt5wlx/pju/6QSnj5MjKB7hGrO5njCMrgygw+MwK6G+sfV5MhFcciaZvfwWJA==
X-Received: by 2002:a17:906:74d9:b0:9a1:d29c:6aaa with SMTP id
 z25-20020a17090674d900b009a1d29c6aaamr2079951ejl.39.1694184528227; 
 Fri, 08 Sep 2023 07:48:48 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 fx12-20020a170906b74c00b0099ccee57ac2sm1123702ejb.194.2023.09.08.07.48.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 07:48:47 -0700 (PDT)
Date: Fri, 8 Sep 2023 16:48:46 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Tim Wiederhake <twiederh@redhat.com>
Cc: qemu-devel@nongnu.org, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>, "Daniel P . =?UTF-8?B?QmVycmFuZ8Op?="
 <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S .
 Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 00/10] Generate x86 cpu features
Message-ID: <20230908164846.184aba1c@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230908124534.25027-1-twiederh@redhat.com>
References: <20230908124534.25027-1-twiederh@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Fri,  8 Sep 2023 14:45:24 +0200
Tim Wiederhake <twiederh@redhat.com> wrote:

> Synchronizing the list of cpu features and models with qemu is a recurring
> task in libvirt. For x86, this is done by reading qom-list-properties for
> max-x86_64-cpu and manually filtering out everthing that does not look like
> a feature name, as well as parsing target/i386/cpu.c for cpu models.

modulo fixing typos/name conflicts in 1st 3 patches,

I don't think it's a great idea for libvirt (or any other user) to parse
QEMU source (whether it's C code or yaml) or other way around for users
to influence QEMU internals.

QEMU does provides QMP interface for introspection of CPU models and it
should be used as a mean to discover new CPU models as well as new
feature names. If something is missing there we should fix it up
to make it usable for libvirt.

> This is a flawed, tedious and error-prone procedure. Ideally, qemu
> and libvirt would query a common source for cpu feature and model
> related information. Meanwhile, converting this information into an easier
> to parse format would help libvirt a lot.
> 
> This patch series converts the cpu feature information present in
> target/i386/cpu.c (`feature_word_info`) into a yaml file and adds a
> script to generate the c code from this data.

 
> A patch set to convert the cpu model data (`builtin_x86_defs`) in the
> same way will follow.

while theoretically you can parse feature_word_info with some sort of reliability,
you can't do that reliably with CPU model definitions in builtin_x86_defs
as the later is just a skeleton. Actual CPU models definitions are
a function of used machine type, accelerator and host kernel. 

> 
> v1: https://lists.nongnu.org/archive/html/qemu-devel/2023-08/msg02005.html
> 
> Changes since v1:
> * Incorporated changes from
>   https://lists.nongnu.org/archive/html/qemu-devel/2023-08/msg04241.html.
> * Changed data format from xml to yaml, as proposed in
>   https://lists.nongnu.org/archive/html/qemu-devel/2023-09/msg01033.html.
>   Using json has some drawbacks, see
>   https://lists.nongnu.org/archive/html/qemu-devel/2023-08/msg03384.html.
> * Rebased on top of current master. Features added in the meantime:
>   amx-complex and vmx-enable-user-wait-pause
> * Split up the reformatting of feature_word_info.c.inc to make it easier
>   to review. These patches could be squashed together before merging.
> 
> Tim Wiederhake (10):
>   target/i386: Add missing feature names in FEAT_VMX_EPT_VPID_CAPS
>   target/i386: Fix feature names in FEAT_VMX_EPT_VPID_CAPS
>   target/i386: Fix duplicated feature name in FEAT_KVM
>   target/i386: Split out feature_word_info
>   target/i386: Translate feature_word_info to yaml
>   target/i386: Format feature_word_info.c.inc: Remove comments
>   target/i386: Format feature_word_info.c.inc: feat_names
>   target/i386: Format feature_word_info.c.inc: Unfold cpuid member
>   target/i386: Format feature_word_info.c.inc: Whitespaces and trailing
>     commas
>   target/i386: Autogenerate feature_word_info.c.inc
> 
>  target/i386/cpu.c                   |  677 +-----------------
>  target/i386/feature_word_info.c.inc | 1030 +++++++++++++++++++++++++++
>  target/i386/feature_word_info.py    |   62 ++
>  target/i386/feature_word_info.yaml  |  697 ++++++++++++++++++
>  4 files changed, 1790 insertions(+), 676 deletions(-)
>  create mode 100644 target/i386/feature_word_info.c.inc
>  create mode 100755 target/i386/feature_word_info.py
>  create mode 100644 target/i386/feature_word_info.yaml
> 



