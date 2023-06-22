Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D46F973A208
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 15:40:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCKWy-0000eF-2p; Thu, 22 Jun 2023 09:39:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1qCKWv-0000dw-Ey
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 09:39:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1qCKWt-0002mA-Ql
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 09:39:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687441159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ee2qq69m2UjhxJo00LbNqGtkBW1frUMVLIXumMTqWXw=;
 b=by37itDPvkVW96CuJ/HqivosuloNL0ar8jc60Ts5FcLpQ5XAB7FbwgolBQ8smjqLLn0OTW
 0qE9DuwDBizB/SOoFrunLdzcg/CAas6AfV3QNFr/5L7FEYViBtz4kjO5OHRfqhAeNB8WdQ
 zytjkaxZLiSHHX0onzdDmivsgavsVRs=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-HMymjbuBNx2v3i4hdoLJDA-1; Thu, 22 Jun 2023 09:39:17 -0400
X-MC-Unique: HMymjbuBNx2v3i4hdoLJDA-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-76531f6ae45so83892185a.3
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 06:39:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687441156; x=1690033156;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ee2qq69m2UjhxJo00LbNqGtkBW1frUMVLIXumMTqWXw=;
 b=jCLY9ThhwhkhcpuvEaBYtf9wQDr7SZ8dkAKRhBtjSRpoNd4toQvJFWe4xXZURn5trW
 AceFuGOiV+LfbXUvl5drAGpVWUUWWF0ATYV6sQmESOSCKQJRRjHUPCVwp6RpfdJVbHX6
 XFR6d6Es5TYFebUJoTvRQ/w5n+cu+C83VHiDRbNZlNSD2AR4fgXGjhriwDF7GnxlDDtp
 XWaaV4P6HchXr8W2rHqaxZwBWYlw17/iP3aVa2sj+9CcytkYgS+gxNdpUF0NeYQU9h3D
 ZS2B8eVvEs6Y63bXZ3/FGBgvgHfoo0jdqkaSZJUq4Mw5ZKLblJzUuSxT509tU+W5AIE+
 zr1A==
X-Gm-Message-State: AC+VfDw0D4sT1t6zNKvZbtmlh09LvZ0r9ext5Ez4RTZRU1/eRGaWAmHJ
 cC3Cj1v0wZC1DH7gudbKHObhSL8GlNVq7XqOB18dXqbJSYL4Csxf2HvlFCr8OLUTyXsvUNAq8Hx
 fLPjGJDmGZhfJOB4=
X-Received: by 2002:a05:620a:d8e:b0:75f:b4:7b87 with SMTP id
 q14-20020a05620a0d8e00b0075f00b47b87mr20597276qkl.24.1687441156526; 
 Thu, 22 Jun 2023 06:39:16 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5MqsTYNKeyRAUxrsohDo0jXSXTcQoF7w1gLvFGtRIYZTlfOHhMrc/ISKxzBRBB6MJpc5mI5Q==
X-Received: by 2002:a05:620a:d8e:b0:75f:b4:7b87 with SMTP id
 q14-20020a05620a0d8e00b0075f00b47b87mr20597254qkl.24.1687441156249; 
 Thu, 22 Jun 2023 06:39:16 -0700 (PDT)
Received: from [192.168.100.28] ([82.142.8.70])
 by smtp.gmail.com with ESMTPSA id
 c9-20020ae9e209000000b007623e63f642sm3453277qkc.32.2023.06.22.06.39.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Jun 2023 06:39:15 -0700 (PDT)
Message-ID: <269b9686-f7df-72de-ae6b-242767feccaa@redhat.com>
Date: Thu, 22 Jun 2023 15:39:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2] tpm_crb: mark memory as protected
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 jasowang@redhat.com, mst@redhat.com, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, marcandre.lureau@redhat.com,
 eric.auger@redhat.com, Peter Xu <peterx@redhat.com>
References: <20230620195054.23929-1-lvivier@redhat.com>
 <20230620195054.23929-3-lvivier@redhat.com>
 <CAFEAcA_r31PU1LRka36dSJ6vZ2boP33MB=Ns5hDMRrSTN1Lmag@mail.gmail.com>
From: Laurent Vivier <lvivier@redhat.com>
In-Reply-To: <CAFEAcA_r31PU1LRka36dSJ6vZ2boP33MB=Ns5hDMRrSTN1Lmag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 6/22/23 15:12, Peter Maydell wrote:
> On Tue, 20 Jun 2023 at 20:51, Laurent Vivier <lvivier@redhat.com> wrote:
>>
>> This memory is not correctly aligned and cannot be registered
>> by vDPA and VFIO.
> 
> Isn't this a vDPA/VFIO problem? There's no requirement
> for RAM MemoryRegions to be aligned in any way. Code
> that doesn't want to work with small or weirdly aligned
> regions should skip them if that's the right behaviour
> for that particular code IMHO.
> 

Marc-André proposed to modify vDPA code to skip the region but Michal disagreed:

https://lists.nongnu.org/archive/html/qemu-devel/2022-11/msg03670.html

No one wants the modification, so the problem cannot be fixed.

Thanks,
Laurent


