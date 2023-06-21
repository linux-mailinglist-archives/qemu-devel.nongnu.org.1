Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3D873893B
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 17:33:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBzp9-0003Nw-MA; Wed, 21 Jun 2023 11:32:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qBzp7-0003Nk-2i
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 11:32:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qBzp5-0005Rn-Aw
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 11:32:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687361561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8ULFljKopCnJv2Otux0903HhUd3oiiP0Lc3NYFHN5yg=;
 b=gdF2T3frWzb42GjsbFk9itJHtEQiyk0CgIKOAKinCnHBmSvvXGKp/D8VTyHbq6C6pRwid4
 1aX1+kuamCQ1cgA901EmVyukupTJ0NRd4KdDIo2s2SxyJGcULJnAW7W3W+ui1SO9bHorSj
 cE92WzHptG+XHpnD277pFWYRP1vrNjY=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-7jMQlKb3PyOP30iSzVG3ag-1; Wed, 21 Jun 2023 11:32:39 -0400
X-MC-Unique: 7jMQlKb3PyOP30iSzVG3ag-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-62ff7a8b9aeso9528876d6.1
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 08:32:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687361559; x=1689953559;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8ULFljKopCnJv2Otux0903HhUd3oiiP0Lc3NYFHN5yg=;
 b=OOZYBlw7Ox/FPoi7FFW4Yum237xOiabh5RTcvhV7q5EcUs+gVEYs+XPBbi35RIB5qP
 8NJLeI3sxq62TtIDXAnimmmHGEXw5YKA+K9Uhe2inFBNvIZP8hD9jo5kRMxfztHSrqmo
 6ipGBKbzti8xiNnSHAwD9Eh95dP0DdYkj1tScDYUfbCVf4Yu3/GRT4W1HzeWPONqcMnY
 1CFEpgw0wsII0Irqwf78ZNqmq6MEctQ7fihgiscevnyY91Zjp4fSi3nAJDSxTWiEokDU
 B/eQhV8yCarElYth0EeYuwQhVPvNZBjuy5+Cku+sB7UZVM4mjJuawRPOERdhunTATPLm
 9yhw==
X-Gm-Message-State: AC+VfDy76DqlukMAzawyLF0+0IWysvgs6JNZmNkODig4S7woDqStyy4l
 avRAKTBC9CQcPeHg/UNXa3vWhLc4VzR2sjWAu4NQEtx3g2fcNehgM3Ot+2TX5NaJQloM9fVAV9F
 60TUqfLwOzvTXs14=
X-Received: by 2002:ad4:5945:0:b0:625:aa48:e50f with SMTP id
 eo5-20020ad45945000000b00625aa48e50fmr18278100qvb.6.1687361559271; 
 Wed, 21 Jun 2023 08:32:39 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5jGOMA/wYJbQ7vm0iAw+4KDBYWdh547jf97tdEUouGeD8EmcBC0CY4dxVxqxPTwuByFF7mvg==
X-Received: by 2002:ad4:5945:0:b0:625:aa48:e50f with SMTP id
 eo5-20020ad45945000000b00625aa48e50fmr18278059qvb.6.1687361558920; 
 Wed, 21 Jun 2023 08:32:38 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 t2-20020a0cb382000000b0063004b5482csm2618885qve.92.2023.06.21.08.32.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jun 2023 08:32:38 -0700 (PDT)
Date: Wed, 21 Jun 2023 11:32:37 -0400
From: Peter Xu <peterx@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 jasowang@redhat.com, mst@redhat.com, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, marcandre.lureau@redhat.com,
 eric.auger@redhat.com
Subject: Re: [PATCH 0/2] vhost-vdpa: skip TPM CRB memory section
Message-ID: <ZJMYFVHlQI085zSi@x1n>
References: <20230620195054.23929-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230620195054.23929-1-lvivier@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jun 20, 2023 at 09:50:52PM +0200, Laurent Vivier wrote:
> An error is reported for vhost-vdpa case:
> qemu-kvm: vhost_vdpa_listener_region_add received unaligned region
> 
> Marc-André has proposed a fix to this problem by skipping
> the memory region owned by the TPM CRB but it seems more generic
> to skip not DMA-able memory.
> 
> We have a memory flag for that, RAM_PROTECTED.
> 
> This series expands the memory API to provide a way to initialize
> a "protected" memory region and use it with the TPM CRB object.
> 
> For the previous discussions, see
> 
> https://lists.nongnu.org/archive/html/qemu-devel/2022-11/msg03670.html
> 
> and from Eric for VFIO:
> 
> https://lore.kernel.org/all/20220506132510.1847942-1-eric.auger@redhat.com/
> https://lore.kernel.org/all/20220524091405.416256-1-eric.auger@redhat.com/
> 
> Bug: https://bugzilla.redhat.com/show_bug.cgi?id=2141965
> 
> Thanks,
> Laurent
> 
> Laurent Vivier (2):
>   memory: introduce memory_region_init_ram_protected()
>   tpm_crb: mark memory as protected

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


