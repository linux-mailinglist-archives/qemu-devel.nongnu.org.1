Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1383472FF26
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 14:53:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9Q0E-00013n-IW; Wed, 14 Jun 2023 08:53:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q9Q00-00012v-My
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 08:53:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q9Pzz-0005q5-3e
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 08:53:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686747194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2TU3DB+hHl0fle96OtaOvgjjqADuHg9vin2NGT2ni+Q=;
 b=O0ZzKiVWcXSpzNsnhVXj8g6zdC3Gb7VmUsir5e36Wm6mTEmJIDLShcsi2q4/NWjHLzi1Rf
 A5T/A6WI1HU5UzpQok+7f8QCTVJ9a3H4NppW7aeSvsV32wq3J4RpuPdYD6bZw64za0TMWv
 WYKCK7DlRX5BlJgjwWTnu8jMIwjHSIc=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-XxMLc2G0OCOQtWfJWXZuqA-1; Wed, 14 Jun 2023 08:52:02 -0400
X-MC-Unique: XxMLc2G0OCOQtWfJWXZuqA-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-75ec91f26c8so146065685a.1
 for <qemu-devel@nongnu.org>; Wed, 14 Jun 2023 05:52:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686747122; x=1689339122;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2TU3DB+hHl0fle96OtaOvgjjqADuHg9vin2NGT2ni+Q=;
 b=gy6aensJQ1/uN2q5ursPVrl6q4ytgTJldxhvLMHeUNSTypmWv5tkzspNsH9XItWawd
 pfNgjtSh6Ka+JU6rTCx8mjF9y8rUAgARVjjK/scqNduSh+kdg/FwvamOd3+37fsvUWLK
 12EYdZuv2D1FxuTLDHoKXT7PXlzKQ69oRf/EuuucfYd8l4vWKPTw9Y/+cd4bUBPAzoc8
 olD5Kmd6emnM8cnFFxzrlw9sXp7tTjsViO6WmxB2Y8fetrcDVu4mwYfzP9Ocaku0aaLM
 VX75jGcY2NKHzP8t/2iENM7DUJLSsBvS0U9MPJ9FHA3v6ajRozntoj4g9Rgk0/JptPOu
 +YSg==
X-Gm-Message-State: AC+VfDyTpUakhEaBmByAwEmy6E82nN42k0OzWTFPxzuqx47cUNQqC/lZ
 6JY9UL4t5ElT9nmeid+igHV1TZm8sQ9fV6YcOK41KYuV/L/+ru0gVLn5WQPDSE6DEKEdNCmVkct
 GIG/tGqfZeRwloP8=
X-Received: by 2002:a05:620a:261b:b0:75d:53ee:ced2 with SMTP id
 z27-20020a05620a261b00b0075d53eeced2mr17292466qko.3.1686747121946; 
 Wed, 14 Jun 2023 05:52:01 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7DzLs6JjHoryyrHIIFOiDBx5b3iS9dt2aKBIEKRutZc4aHOmYybg25SpOrTaTYXo1xPIyhhQ==
X-Received: by 2002:a05:620a:261b:b0:75d:53ee:ced2 with SMTP id
 z27-20020a05620a261b00b0075d53eeced2mr17292436qko.3.1686747121510; 
 Wed, 14 Jun 2023 05:52:01 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 o8-20020a05620a130800b0075caf18008bsm4230115qkj.116.2023.06.14.05.51.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jun 2023 05:52:00 -0700 (PDT)
Date: Wed, 14 Jun 2023 08:51:58 -0400
From: Peter Xu <peterx@redhat.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "eduardo@habkost.net" <eduardo@habkost.net>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "david@redhat.com" <david@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>,
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>,
 "cjia@nvidia.com" <cjia@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>
Subject: Re: [PATCH v3 5/5] intel_iommu: Optimize out some unnecessary UNMAP
 calls
Message-ID: <ZIm37va6lV11FnP7@x1n>
References: <20230608095231.225450-1-zhenzhong.duan@intel.com>
 <20230608095231.225450-6-zhenzhong.duan@intel.com>
 <ZII7UyaKrArIM5Qg@x1n>
 <SJ0PR11MB6744CBC59B0BE971EE24D3799251A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <SJ0PR11MB674410E7D30E10736AB90BA8925AA@SJ0PR11MB6744.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SJ0PR11MB674410E7D30E10736AB90BA8925AA@SJ0PR11MB6744.namprd11.prod.outlook.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, Jun 14, 2023 at 09:38:41AM +0000, Duan, Zhenzhong wrote:
> It looks the benefit of this patch is negligible for legacy container and iommufd.
> I'd like to drop this patch as it makes no difference, your opinion?

Thanks for the test results.  Sounds good here.

-- 
Peter Xu


