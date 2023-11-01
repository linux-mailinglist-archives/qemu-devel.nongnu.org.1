Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6427DE656
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 20:20:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyGl4-00069i-V9; Wed, 01 Nov 2023 15:20:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qyGl2-00069W-73
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 15:20:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qyGl0-0000Ls-Q6
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 15:20:03 -0400
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-WcSgO22lNoG0wuT5bOUBjw-1; Wed, 01 Nov 2023 15:19:59 -0400
X-MC-Unique: WcSgO22lNoG0wuT5bOUBjw-1
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-6d312683a53so19253a34.1
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 12:19:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698866399; x=1699471199;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=isHcJK8WmxdYGmLYDkJd2kzo5ICSHSGg17SNmzNpiSs=;
 b=jIkD0AtXR7hseszNDrBr6eOQS46e9eQAv0qJKKa/1WF3VGHNn3rrQt1OF7uCgTMzOv
 wllXxrBkskCqlY59bgwQzM3K5JaMx+g0L/hMsO96oL9lTil5Z+frMYWHFyqIeuNR/A5b
 eqcRdkaulL6EbunwS7drg7i8NKr1dBSCVHzNqgQN4B5Z5vmn8yFyhaNUQKRVJlLBUa/+
 aDzsbtfT3rIF5ThiLq9X/FgYnh+zMoKlo8qPGt7tvczaWTPoGgRKpFoqQKJVGJr13oIQ
 HmI/V5woojJA07ufXTY5XDgUuKxcxS02lVTG7hyZZrZ/Q8rxXXn80AYphsG8TkmMTPrs
 GBYA==
X-Gm-Message-State: AOJu0YwGLa3uhy947z5IjKLgX0HB3bsUC4txiNp2s9/Spnf8iuH5WyZs
 nJvP8Vv5y5nYVa0pPHPBdNKQAeQ5q8LhlxgPeMWXmPo+KHw/EI/1teOCt5z5SxJYxglGftDZjxj
 o6/jBjexSAk3oZvc=
X-Received: by 2002:a05:6830:390d:b0:6bd:6d51:e9e5 with SMTP id
 br13-20020a056830390d00b006bd6d51e9e5mr19372230otb.0.1698866399217; 
 Wed, 01 Nov 2023 12:19:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENI+uiSuWPYLTh8YOAmJoQP/F2EVpJmTdyaWUR5xAvypdNlsuAMm6spAVgxVGTWizDTUcy2A==
X-Received: by 2002:a05:6830:390d:b0:6bd:6d51:e9e5 with SMTP id
 br13-20020a056830390d00b006bd6d51e9e5mr19372211otb.0.1698866398920; 
 Wed, 01 Nov 2023 12:19:58 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 3-20020ac85643000000b00419b5274381sm1643678qtt.94.2023.11.01.12.19.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 12:19:58 -0700 (PDT)
Date: Wed, 1 Nov 2023 15:18:24 -0400
From: Peter Xu <peterx@redhat.com>
To: Mattias Nissler <mnissler@rivosinc.com>
Cc: stefanha@redhat.com, jag.raman@oracle.com, qemu-devel@nongnu.org,
 john.levon@nutanix.com, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v6 2/5] softmmu: Support concurrent bounce buffers
Message-ID: <ZUKkgL9RiYogDxkG@x1n>
References: <20231101131611.775299-1-mnissler@rivosinc.com>
 <20231101131611.775299-3-mnissler@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231101131611.775299-3-mnissler@rivosinc.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Wed, Nov 01, 2023 at 06:16:08AM -0700, Mattias Nissler wrote:
> When DMA memory can't be directly accessed, as is the case when
> running the device model in a separate process without shareable DMA
> file descriptors, bounce buffering is used.
> 
> It is not uncommon for device models to request mapping of several DMA
> regions at the same time. Examples include:
>  * net devices, e.g. when transmitting a packet that is split across
>    several TX descriptors (observed with igb)
>  * USB host controllers, when handling a packet with multiple data TRBs
>    (observed with xhci)
> 
> Previously, qemu only provided a single bounce buffer per AddressSpace
> and would fail DMA map requests while the buffer was already in use. In
> turn, this would cause DMA failures that ultimately manifest as hardware
> errors from the guest perspective.
> 
> This change allocates DMA bounce buffers dynamically instead of
> supporting only a single buffer. Thus, multiple DMA mappings work
> correctly also when RAM can't be mmap()-ed.
> 
> The total bounce buffer allocation size is limited individually for each
> AddressSpace. The default limit is 4096 bytes, matching the previous
> maximum buffer size. A new x-max-bounce-buffer-size parameter is
> provided to configure the limit for PCI devices.
> 
> Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


