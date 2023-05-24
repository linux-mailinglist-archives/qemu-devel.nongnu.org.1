Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D403570EF7F
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 09:35:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1j11-0002tz-To; Wed, 24 May 2023 03:34:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q1j0z-0002sK-UQ
 for qemu-devel@nongnu.org; Wed, 24 May 2023 03:34:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q1j0y-00066A-Da
 for qemu-devel@nongnu.org; Wed, 24 May 2023 03:34:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684913671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XQ+AnM2/E3xApIGY+KniRAi8RAIJ8xqiVJ99TmF6Z/E=;
 b=XoZjbaaNUwZrnsBiqVJLnuwil8pDUY7eYw5whfxovYolalbEqobNPpCbtBH3BeybbyaUzx
 bjBfLR9M4T/jJnlBF16wwl+4xUVp+7+Nj9Owzt4RPnlVQHfzWHwXHqEgrVfyaZf4qul44p
 O0ACCsK0uqSTwDMYhwV7R7CueAVkVkk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-4AzGZuc7Nva0d25Q7SbPqQ-1; Wed, 24 May 2023 03:34:28 -0400
X-MC-Unique: 4AzGZuc7Nva0d25Q7SbPqQ-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-510526d2a5fso2426372a12.0
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 00:34:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684913667; x=1687505667;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XQ+AnM2/E3xApIGY+KniRAi8RAIJ8xqiVJ99TmF6Z/E=;
 b=iwSXdr5sSaFAB3/n2feNPMOdfduAY/JNcHw6VRiwwuHtF0PiLirq9r6n40Eqm9+2J5
 X2eXbHTjiZ5NZquWaDpsNcNoAe5RPZoDtPCvs3VIfVP//ozUdSQwRgaFZ4O037+K1bsY
 QZZJ5vV6ymwBOZcNIeWRkeFXyn0kWTrxSjMd1LW2tKYYTfLAMwkBUg1fokStalMqtQG5
 p0eMTDUkpxIkrBDdRaU+B3Gkq8PfAYIXQt4EYMtHAG0Va7vC2Xg+0QbFOKtkauslFgvt
 jDyUgUnZCdVxztkWkwBY8PoaIUKvCmTQx9AgskakFeA4eRsoAEYWWhySrLxx9YU4IDbB
 quhA==
X-Gm-Message-State: AC+VfDzO+EEDvdGWwySUbHahOnEEmSCJmpAfaEHpzPmc4orM1iCVBg+S
 OiZ0wZujchP5zkdLERg0+PSS5D/NuHB5EVXW110+np/nmVE5BsC2rYDMbBrf2uncExSs4Mj2ysH
 QxiL00vcriVKsMj0=
X-Received: by 2002:a17:907:9708:b0:959:b757:e49 with SMTP id
 jg8-20020a170907970800b00959b7570e49mr16836859ejc.1.1684913667078; 
 Wed, 24 May 2023 00:34:27 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4p9Qa/b1sn33+U6Iim73Nsfc1b+4+wIaFJp7tGVCR+J/2iA2niQmWY0/XL9KzZhCckhLWUVQ==
X-Received: by 2002:a17:907:9708:b0:959:b757:e49 with SMTP id
 jg8-20020a170907970800b00959b7570e49mr16836835ejc.1.1684913666770; 
 Wed, 24 May 2023 00:34:26 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-176-64.web.vodafone.de.
 [109.43.176.64]) by smtp.gmail.com with ESMTPSA id
 s14-20020a170906c30e00b0094f410225c7sm5251756ejz.169.2023.05.24.00.34.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 May 2023 00:34:26 -0700 (PDT)
Message-ID: <d8986a58-16c0-58d3-3b65-946cd13a2501@redhat.com>
Date: Wed, 24 May 2023 09:34:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH 11/11] hw/virtio: Make vhost-vdpa.c target-agnostic to
 build it once
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Peter Xu <peterx@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 David Hildenbrand <david@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Eric Farman <farman@linux.ibm.com>, Fam Zheng <fam@euphon.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-s390x@nongnu.org
References: <20230523163600.83391-1-philmd@linaro.org>
 <20230523163600.83391-12-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230523163600.83391-12-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 23/05/2023 18.36, Philippe Mathieu-Daudé wrote:
> Replace TARGET_PAGE_MASK -> qemu_target_page_mask() and
> TARGET_PAGE_ALIGN() -> qemu_target_page_align() so we don't
> need the target-specific "cpu.h" header.
> 
> These macros are used in the MemoryListener add/del handlers
> (vhost_vdpa_listener_skipped_section is only called by
> vhost_vdpa_listener_region_add) which are not hot-path.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/virtio/vhost-vdpa.c | 16 ++++++++--------
>   hw/virtio/meson.build  |  3 ++-
>   2 files changed, 10 insertions(+), 9 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>



