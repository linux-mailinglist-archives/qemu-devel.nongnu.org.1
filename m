Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 94327715EDF
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 14:20:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3yJr-0007CD-3u; Tue, 30 May 2023 08:19:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q3yJA-0006y7-N7
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:18:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q3yJ9-0006th-0z
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:18:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685449114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wGEdMXWLOZlxhss834tVjbMCI05NaHZQ2dSU3138BTk=;
 b=bBhOMGnbVzLFtvwkrc66E6FM0ogiYTvE2jbR10Vrmzb8FfkI5gALFF+pivmktU7rUECIYK
 cgZBORE8rGFVr5G7gmTgUB6DZtZD9h8DPKwXJmJVVDvtF0THyGgwB087Lvwme/7r+eoCZQ
 1aRK8NVnUgVdzu9SZbhJE2ByAQw4qgs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-Hi7b6qVaOKSvz60kvGf6pw-1; Tue, 30 May 2023 08:18:33 -0400
X-MC-Unique: Hi7b6qVaOKSvz60kvGf6pw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f60fb7b31fso16605315e9.2
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 05:18:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685449112; x=1688041112;
 h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
 :content-language:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wGEdMXWLOZlxhss834tVjbMCI05NaHZQ2dSU3138BTk=;
 b=f0Qv4GQeXlWO+Q5E/hpo4ecQ0cvn45nRu9UrUOMz/EMe4U4bcoN1RY159+C/T+wW0O
 6T/z6WSiL757ITs1YHsLhqbl76RbMf0a3PY1t9qFOa5rOb1L3oyhD/o7o31lS9j7AtJU
 qui3BcTtO7vRrLpcAYbcgoLM//88YgD/ZE1oghZ1QH7V2+Y3wtTZpIpwL1RA9Yoleo1J
 aU6TooJyAj4pWIWnDSOqOs+cvmFDqWATM77T2npaD1lXP22AHW+vw2TF8f+TpfywWt/p
 7VZK56jjs9o9i4l1bGunSyWXcNWDP0/rW7JrSJU3hXQwgeIF61PKiUMw5YXKXKOImCKH
 0Qbg==
X-Gm-Message-State: AC+VfDyjHY4TBHtdOGso5hMRT7mIwgWzI8s68LqpXR3cWjKlB9+hTuFo
 ckXECFXnpc6Io7tMLGw9qBp4w31R76g4kPqdjy1MUl7Nwm8s5YmvvdfSvJCLk+B4wnRDAMTxGJh
 tMjPy3P1AquuCDfA=
X-Received: by 2002:a1c:f615:0:b0:3f6:2ee:6993 with SMTP id
 w21-20020a1cf615000000b003f602ee6993mr1454111wmc.4.1685449112051; 
 Tue, 30 May 2023 05:18:32 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ44leqoYqUfA4pjQI/I+kPPjLj65hQGXt6bWD6YIgeBanuLCUKefPUaLb0UA/tO5HBCpyC5Iw==
X-Received: by 2002:a1c:f615:0:b0:3f6:2ee:6993 with SMTP id
 w21-20020a1cf615000000b003f602ee6993mr1454100wmc.4.1685449111744; 
 Tue, 30 May 2023 05:18:31 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-176-11.web.vodafone.de.
 [109.43.176.11]) by smtp.gmail.com with ESMTPSA id
 x21-20020a05600c21d500b003f6041f5a6csm17319225wmj.12.2023.05.30.05.18.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 05:18:31 -0700 (PDT)
Message-ID: <3188708d-f7ae-27c2-7bb2-0ac50b08c79a@redhat.com>
Date: Tue, 30 May 2023 14:18:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, berrange@redhat.com,
 qemu-s390x <qemu-s390x@nongnu.org>
References: <20230527092851.705884-1-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 0/5] meson: replace submodules with wrap files
In-Reply-To: <20230527092851.705884-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 27/05/2023 11.28, Paolo Bonzini wrote:
> This series replaces git submodules for bundled libraries with .wrap
> files that can be used directly by meson for subprojects. 
...
> The remaining submodules consist of tests/lcitool/libvirt-ci and the
> firmware in roms/.

We talked about moving the contents of roms/ to a separate repository a 
couple of times ... maybe it's time now that we really do it?

(However, when I tried to tackle the "do we need to ship the firmware 
sources with the main tarball" problem the last time, there was no consensus 
how to do it best, see 
https://lore.kernel.org/qemu-devel/20221128092555.37102-1-thuth@redhat.com/ 
... maybe something to discuss at KVM forum...)

> The former is only used in very specific cases,
> while the latter is mostly used only as a pointer used to create the QEMU
> tarball.  Unfortunately, git-submodule.sh is still needed for roms/SLOF,
> parts of which are used in the QEMU build process for pc-bios/s390-ccw;
> more on this later in this cover letter.
> 
> I'm not sure what's the best way to proceed for roms/SLOF.  Some
> possibilities, in no particular order, include:
> 
> * doing nothing
> 
> * merging --with-git-submodules with --enable-download, and
>    moving the git-submodule.sh rules from the main Makefile to
>    pc-bios/s390-ccw/ (my favorite option)
> 
> * copying the relevant SLOF files into pc-bios/

Considering that SLOF is also rather on life support already (there is now 
VOF for the sPAPR machine instead, Alexey left IBM, ...), I also wouldn't 
mind the third option, I think.

But of course we can also start with option 2 and go for option 3 later.

  Thomas


