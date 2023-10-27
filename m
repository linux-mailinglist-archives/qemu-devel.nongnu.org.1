Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE4B7D9425
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 11:48:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwJS4-00058K-8c; Fri, 27 Oct 2023 05:48:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qwJRz-0004vu-SM; Fri, 27 Oct 2023 05:48:20 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qwJRw-0005zO-CQ; Fri, 27 Oct 2023 05:48:18 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-32db8f8441eso1295130f8f.0; 
 Fri, 27 Oct 2023 02:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698400095; x=1699004895; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=30VwI2HQrqCL5YyhF8qmfbeeHlzGfWBEtfc4fCXo8Fs=;
 b=fkCVkvlMqQLeq3JKZAR7+tTicsUjXDVkuNZ5JjmvidaxMQOZBJUHl6pZYNdBpf+EU1
 8roS2U/3RHXD7BqIljTTlBoyh5hxYK1Lc/iUgqdFaAWx6VrWBPjcudWOOREs1o+BRsb3
 04Ap5CElfdw21GQJw2fa0A4d3dGEGPZpz1JSGg1mc2OWnTxXIPZHafKiT35jOEX2rsx+
 J+AswLu6uOzCJhQLAgR/v3T/6yIQ30CYuGhEWeG29Q3C8FVrb5YLbI9cBW+MKIWa3BOJ
 wLbNDkwfB7CdA2ylAZ/Hs2WF0CW8kpKYH9qXrL5ekIwgvhHdKZGmVhfircmCgQwGik6R
 QutA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698400095; x=1699004895;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=30VwI2HQrqCL5YyhF8qmfbeeHlzGfWBEtfc4fCXo8Fs=;
 b=UUN5lmFnOQw6ywKsenA79PdfZUtmOASYmoHIaUsWglxru6aaeIQhlR2Vo7k4/+jvGK
 UwS2j/ZCgsCo8TjKBMi+5eDZEEUDVwgNrhy1phTpZn5aGjV3ORUKC7caT+L6ml4uG52J
 2PCAjLIFoNMVcMdqb6Rv0YGfU/5NelIQT3m2jfkCH4OU3JDjhM9eKxSjdq7gjlgGZuie
 DDK9YnlwL59BH08FQEjoDAO0GkUt2+IYd37Ykmd5BXapePFPnX1823dQuusW+ZBTrZie
 3qWNGf+3ZVre4d42lzWFSLhIlsxYFaxSt/oqBATAO7+04nDjTfSihPn7RdtJPtM4aTrM
 RN1A==
X-Gm-Message-State: AOJu0Yz/S6z/dY5I4YAyYS3jAIYfuRqIYpTdLTk7QqLAzJGpNyjR5fe0
 EfRdZ/l9QprQM0fgjUUpAA8=
X-Google-Smtp-Source: AGHT+IE4PpSyRDRjuLCwnnRqMs4Ez7+O/3yvQMMGSADruwPllbL3a4A8idM4xcMnD9poi1dGJZ1Jjg==
X-Received: by 2002:a05:6000:1361:b0:32d:9b80:e2c6 with SMTP id
 q1-20020a056000136100b0032d9b80e2c6mr1636403wrz.26.1698400094647; 
 Fri, 27 Oct 2023 02:48:14 -0700 (PDT)
Received: from [192.168.10.177] (54-240-197-235.amazon.com. [54.240.197.235])
 by smtp.gmail.com with ESMTPSA id
 e9-20020a5d5949000000b00326f5d0ce0asm1389222wri.21.2023.10.27.02.48.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Oct 2023 02:48:14 -0700 (PDT)
Message-ID: <322697f1-c4fe-40ab-88ce-f99f9d1fe4d6@gmail.com>
Date: Fri, 27 Oct 2023 10:48:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 26/28] hw/i386/pc: use qemu_get_nic_info() and
 pci_init_nic_devices()
Content-Language: en-US
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-block@nongnu.org,
 xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
 Bernhard Beschow <shentey@gmail.com>, Joel Upham <jupham125@gmail.com>
References: <20231025145042.627381-1-dwmw2@infradead.org>
 <20231025145042.627381-27-dwmw2@infradead.org>
From: "Durrant, Paul" <xadimgnik@gmail.com>
In-Reply-To: <20231025145042.627381-27-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=xadimgnik@gmail.com; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Reply-To: paul@xen.org
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 25/10/2023 15:50, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> Eliminate direct access to nd_table[] and nb_nics by processing the the
> ISA NICs first and then calling pci_init_nic_devices() for the test.
> 
> It's important to do this *before* the subsequent patch which registers
> the Xen PV network devices, because the code being remove here didn't
> check whether nd->instantiated was already set before using each entry.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   hw/i386/pc.c                | 21 +++++++++++----------
>   include/hw/net/ne2000-isa.h |  2 --
>   2 files changed, 11 insertions(+), 12 deletions(-)
> 

Reviewed-by: Paul Durrant <paul@xen.org>


