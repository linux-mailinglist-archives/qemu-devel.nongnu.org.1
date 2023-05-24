Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B987E70F33B
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 11:41:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1kzw-0004eE-ED; Wed, 24 May 2023 05:41:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q1kzp-0004dN-Te
 for qemu-devel@nongnu.org; Wed, 24 May 2023 05:41:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q1kzi-0007ZY-Rz
 for qemu-devel@nongnu.org; Wed, 24 May 2023 05:41:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684921281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ncFz3KnvjZ1xuPlMI50EMQVyMxtVtxLfaOXeKR6frvc=;
 b=di4IjEHz/56WCeYeY8Y1hh22zY6SweYzbj9HoBr/bTu3YHbbA8/YG583fPQ69A22T6152u
 QTdXZ5sA37EP+n8G1GnjbVkfOYw1csMynru0AMJcsecj0wii3LsK1lvuGZ73a0+uonRIPj
 JM1soZzW0usf8rW9bCZFM+ywkyu8KvM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-6JTckBwENvKFnCMrrIthgw-1; Wed, 24 May 2023 05:41:13 -0400
X-MC-Unique: 6JTckBwENvKFnCMrrIthgw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f5df65f9f4so2908125e9.2
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 02:41:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684921272; x=1687513272;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ncFz3KnvjZ1xuPlMI50EMQVyMxtVtxLfaOXeKR6frvc=;
 b=OuPnE+tdFBcmi1+TpiAgV2uXHEXcibFAs/ibmkm/KfS7sM6LbrESW7Zfulrx2/tVzo
 kmqxh7O607O8XI+27pQ5TmppfzDmLWC74Fr1BZxif3xCDGXums4UBy1UJpkHcHzG90B/
 7YDg0hP85ODz+2kDbukxMNeoz5GhK7cZLd7+i1MRkCRhrU0WhD9RrkSv4TJssruqAhbl
 jH8BT817L6Gah+vkWhjFtusZ86QC83VImpGmb+CWIokO3khxR8XgCtyWei5pjxR9ap5P
 3en6Zzj0RR4VzE97bp1fsZywQ/A8o1HB8I9soDG4AQFBjQQqkitBUwSHbPxBo7HKuKVs
 961w==
X-Gm-Message-State: AC+VfDw/z6hr7xx5Nf8hXMeNdqU1bHHC/ZS0jJ5TO8OKZkXJoW3dEWt2
 MXusjfKijVnu6MEz0PjX+K1+Sk9RdsJwFWy+R7XFct+18wZK7uhFAYF+KBfxeIbf4FZxKMwN4Fs
 ii7Q2cVWLkyaZ6KQ=
X-Received: by 2002:a05:600c:2309:b0:3f4:239c:f19 with SMTP id
 9-20020a05600c230900b003f4239c0f19mr11087599wmo.36.1684921272093; 
 Wed, 24 May 2023 02:41:12 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5kWEA55Cd8LGsLth6uCabfBEvWRA9jqmBeEXLCa64jabSDsV7s4ta5Pv6wlNJBNf3E1l+xhw==
X-Received: by 2002:a05:600c:2309:b0:3f4:239c:f19 with SMTP id
 9-20020a05600c230900b003f4239c0f19mr11087574wmo.36.1684921271836; 
 Wed, 24 May 2023 02:41:11 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-176-64.web.vodafone.de.
 [109.43.176.64]) by smtp.gmail.com with ESMTPSA id
 16-20020a05600c025000b003f605814850sm1681851wmj.37.2023.05.24.02.41.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 May 2023 02:41:11 -0700 (PDT)
Message-ID: <6bc486a7-aa8c-8740-8514-ff311fbd8ecb@redhat.com>
Date: Wed, 24 May 2023 11:41:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 03/10] hw/scsi: Rearrange meson.build
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Auger <eric.auger@redhat.com>, "Gonglei (Arei)"
 <arei.gonglei@huawei.com>, David Hildenbrand <david@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-s390x@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
References: <20230524093744.88442-1-philmd@linaro.org>
 <20230524093744.88442-4-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230524093744.88442-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

On 24/05/2023 11.37, Philippe Mathieu-Daudé wrote:
> We will modify this file shortly. Re-arrange it slightly first,
> declaring source sets first.
> 
> No logical change.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/scsi/meson.build | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


