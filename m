Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 570A67D932C
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 11:10:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwIqC-0006mO-KY; Fri, 27 Oct 2023 05:09:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qwIpz-0006m3-AC; Fri, 27 Oct 2023 05:09:03 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qwIpx-0001qM-CA; Fri, 27 Oct 2023 05:09:03 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40806e40fccso12610605e9.2; 
 Fri, 27 Oct 2023 02:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698397736; x=1699002536; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=xk4l/7iC4UJ4bxYDA1m/0zWstbr1oMvAsUPXmEV1lqw=;
 b=AuadqDuTj7FtGLDPd5XOm0/uv1kYMP6PMpP/hMH4pR6Tlhyey4iSSz+zz9yOljrIbD
 K/QHjiN5GkhEdkbdJAskCOoj+xDOHiYYnWdk282irQSMV6m5zs5OHcHezIZpvrWPtxy8
 B8Ph9OLRy3ZJLp3QfJEdRQOfwFR7IKd+1gax4s7msIWZJnPwIzv1IrKXxx4CiL/pZSLD
 WzNMpsckfZgnWzy4P/YDYzuRUjlk5z/5cNIcLKKLKXIHom1FbkftsRoOCiy0QteDKZNL
 R27eyDlRxZI5FBa4h7UZ+FgODBCHyHZRygHeMNrwS7JonuO2p0nkJWlinGDOFXePI17e
 yREQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698397736; x=1699002536;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xk4l/7iC4UJ4bxYDA1m/0zWstbr1oMvAsUPXmEV1lqw=;
 b=ILVCOoahWOhROicAXYFfBXuMBUafdce7VyATTvntxj76/I7rTsbUr0VFs1WPpRU0ba
 vFGSOOTL2c6f7AAiwfsrPHrzoif8U50fHkEdGiZD8flf1g4jcCPx2/Y08zP8EByu8NmH
 ouNKlhSa/v38gbVyNKj4xl+MaIM3icww7tHy1JSM0XbrmF4rAfSuTZjBmCDqmnbwDeDa
 HePCXwcoJXkKX79iQc5DnC1w+MtucQuhl437nsgNoB/FnqC5F0M7HFTRMpwjgsAn84pO
 eWlpsAA6LH4Fdws8e0Znp6Zy/uYLwTGxukZOgoOvfI+opUha9Nbq8pGj3fpipZZHWIh8
 gXZg==
X-Gm-Message-State: AOJu0YzY7SmIy7WT3F9R/op69hLJDZdhVDlxytXkBxOb/3kbmZoOPz+U
 2tOXAjKgZ58iJp/Nwikco08=
X-Google-Smtp-Source: AGHT+IHrQB1bpAc743TK730kpsbJOspNGIhwFQpbDW8MoZPSXg+FX7Yyui8H9QO36a/HiwExPsj/DA==
X-Received: by 2002:a05:600c:4514:b0:408:53d6:10b3 with SMTP id
 t20-20020a05600c451400b0040853d610b3mr1725341wmo.22.1698397736127; 
 Fri, 27 Oct 2023 02:08:56 -0700 (PDT)
Received: from [192.168.10.177] (54-240-197-235.amazon.com. [54.240.197.235])
 by smtp.gmail.com with ESMTPSA id
 g12-20020a05600c310c00b004068e09a70bsm1109446wmo.31.2023.10.27.02.08.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Oct 2023 02:08:55 -0700 (PDT)
Message-ID: <053171c9-fb82-4e19-abda-d41af7b43378@gmail.com>
Date: Fri, 27 Oct 2023 10:08:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 21/28] xen-platform: unplug AHCI disks
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
 <20231025145042.627381-22-dwmw2@infradead.org>
From: "Durrant, Paul" <xadimgnik@gmail.com>
In-Reply-To: <20231025145042.627381-22-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=xadimgnik@gmail.com; helo=mail-wm1-x336.google.com
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
> To support Xen guests using the Q35 chipset, the unplug protocol needs
> to also remove AHCI disks.
> 
> Make pci_xen_ide_unplug() more generic, iterating over the children
> of the PCI device and destroying the "ide-hd" devices. That works the
> same for both AHCI and IDE, as does the detection of the primary disk
> as unit 0 on the bus named "ide.0".
> 
> Then pci_xen_ide_unplug() can be used for both AHCI and IDE devices.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   hw/i386/xen/xen_platform.c | 68 +++++++++++++++++++++++++-------------
>   1 file changed, 45 insertions(+), 23 deletions(-)
> 

Reviewed-by: Paul Durrant <paul@xen.org>


