Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9724B7C8648
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 15:00:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrHlP-0000PX-Nu; Fri, 13 Oct 2023 08:59:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrHlM-0000OT-3L
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 08:59:32 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrHlK-00036q-7P
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 08:59:31 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40684f53ef3so23784145e9.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 05:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697201968; x=1697806768; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Z58jaEGr4DgxiYzRz1RUdDOZApDr880Y7wrVhmUzCXk=;
 b=ixGYVapPKpa/4qWUyscwM+ZoBqJipCuWFIiQCmGnkNdISwhWkAj5Nd6wA9eiwpHJW1
 xfxQsLn/t3EkNucjmwG9iIp/8e4OqgRP8WUbPHBX6PI8hCSEvCq4g6dzzxz5/UkdoND+
 CyrJ26e0lQHlFwJrdmfChse6+iSOg7jmackqClk2/CqeXMHbBaDr2NJUzxOJLY1evtUs
 XJ7lNXfGQYMQgq9Ri3xLlU3RWnVhPKSVfwatJAqkQSt2lIFCyTtRyqMo7SFPaEJkI20X
 ljrEC/99+ZX7dg6fUENi4HPPIP1t1s6jcVmwDnTNjdqP5dQ2QWZieoe9Sda4Mdm/dkWX
 Gffw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697201968; x=1697806768;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Z58jaEGr4DgxiYzRz1RUdDOZApDr880Y7wrVhmUzCXk=;
 b=QyR8J3ihlWKttb0bam05vmiEA032KrI1cs/HLYPtearJHCe5Iu4yro4QR8w5HQeSOQ
 u/HY6Umr71cumtXcEOmwDzqB4Nir/ZpttdBogFGAVhc2hpJF0FCE7eMjO9ZpmdBZ6QTN
 1EukAyHNBpG6J+JmE/z7OVwy3hJ20iEquUdwi39CIzpElSYt27di+7n9Hg3HvcoSuNBh
 4dDOeqTwY/Yz2gn3vom4YFkhOOgYwUGiYChoDYVeJCyO3PSoP7MTUNgKpe0ae/EyjV1A
 4BX3q498ltB1tpFBAmBNu0fiGKxGZbyY04kl3JqkuQzRgXfWhFSLPlUutbeAy1kelNxR
 wLaQ==
X-Gm-Message-State: AOJu0YzHI+X3aLidiQVlqj4FhDuD3obVFu4ZmK2ZWUDWeqTl/iUkbWz0
 faTlXkGgD4+y43OC2EoI8VR55w==
X-Google-Smtp-Source: AGHT+IEBga/qFOhEV8y3sJLTRAF9qdQWXBg3iQMOgnx4XizznG2POgJFGiw8YQBiVqyxAEo28i4tBw==
X-Received: by 2002:a05:600c:2298:b0:406:4573:81d2 with SMTP id
 24-20020a05600c229800b00406457381d2mr22546234wmf.39.1697201968417; 
 Fri, 13 Oct 2023 05:59:28 -0700 (PDT)
Received: from meli.delivery (adsl-26.37.6.0.tellas.gr. [37.6.0.26])
 by smtp.gmail.com with ESMTPSA id
 r8-20020a05600c458800b004064cd71aa8sm62302wmo.34.2023.10.13.05.59.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 05:59:28 -0700 (PDT)
Date: Fri, 13 Oct 2023 15:51:22 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org
Subject: Re: [RFC PATCH 00/78] Strict disable implicit fallthrough
User-Agent: meli 0.8.2
References: <cover.1697183081.git.manos.pitsidianakis@linaro.org>
 <ZSj8YEc0ARdUqFLG@redhat.com>
In-Reply-To: <ZSj8YEc0ARdUqFLG@redhat.com>
Message-ID: <2gxf2.nr1cq95buqhq@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x334.google.com
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

On Fri, 13 Oct 2023 11:14, "Daniel P. Berrangé" <berrange@redhat.com> wrote:
>On Fri, Oct 13, 2023 at 10:47:04AM +0300, Emmanouil Pitsidianakis wrote:
>> 
>> Main questions this RFC poses
>> =============================
>> 
>> - Is this change desirable and net-positive.
>
>Yes, IMHO it is worth standardizing on use of the attribute. The allowed
>use of comments was a nice thing by the compiler for coping with pre-existing
>code, but using the attribute is best long term for a consistent style.
>
>> - Should the `fallthrough;` pseudo-keyword be defined like in the Linux
>>   kernel, or use glib's G_GNUC_FALLTHROUGH, or keep the already existing
>>   QEMU_FALLTHROUGH macro.
>
>As a general rule, if glib provides functionality we aim o use that
>and not reinvent the wheel. IOW, we should just use G_GNUC_FALLTHROUGH.

I agree. My reasoning was:

- The reinvented wheel is only an attribute and not a big bunch of NIH 
  code
- The macro def in glib depends on the glib version you use
- G_GNUC_FALLTHROUGH looks kind of abrasive to my eye, while 
  `fallthrough` blends in with other switch keywords like break.
- C23 standardises fallthrough. We might not ever support C23 but it's 
  good to be consistent with standards and other, larger projects (linux 
  kernel).

I think these (except for myself finding G_GNUC_FALLTHROUGH ugly) make a 
strong case for not using the glib macro, personally. I'd be interested 
to know if there is a counterpoint to it: because I don't want this 
change to cause problems in the future.


Manos

