Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9377571392D
	for <lists+qemu-devel@lfdr.de>; Sun, 28 May 2023 13:30:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3Eaj-0007hx-6y; Sun, 28 May 2023 07:29:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q3Eah-0007hk-Ap
 for qemu-devel@nongnu.org; Sun, 28 May 2023 07:29:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q3Eaf-0008Jd-Kg
 for qemu-devel@nongnu.org; Sun, 28 May 2023 07:29:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685273376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UWaJPhBPDYbKH57SDJxfNtqxoJOdH6oxKtpbVOSSlAA=;
 b=BLdk0WQJIAkNCSOA8cboWYLz4JUc0MbGCe3x0MsPBjO/hW6zKjWc0Soilv+mVn8BLnmKwa
 foSjoUskpT/PlRCY3OPQ3wabzDEHUOLXupX233KNhZY8IzggLe6VxQ8rvoSbie3Ki/xCgI
 yb8/Dxcmi1iHo6SqrBWsdit0BNZZ0Uo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-2khIPjJQOIaw7ljiSr9IiA-1; Sun, 28 May 2023 07:29:34 -0400
X-MC-Unique: 2khIPjJQOIaw7ljiSr9IiA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-30ae8776c12so171810f8f.1
 for <qemu-devel@nongnu.org>; Sun, 28 May 2023 04:29:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685273373; x=1687865373;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UWaJPhBPDYbKH57SDJxfNtqxoJOdH6oxKtpbVOSSlAA=;
 b=H0/7Y9aXmiLzQ6r76kINgT71Rf80RO8QcjsUXHAVnSXwd6vk1RqiFsMYSCGCncNTL3
 5riDRPALpKYGRM0PUorgn+E7Sjsuj4PELuzg+TerGXd6aWZp3WidaOiseVMQ9ZThD0d9
 vS/T/wkT/2lpH/gxj+6dfEq7akywOD8a8RBMP6jwd3zIcJaQgPUztSE7ALcJ72b2vPKI
 VW1XnhZFj/tfrhTYDRdYyZW7W0eln0Eb9kFl342sS6m4sRZ0cXXh+FEUbZnMtcob6x6C
 WvW2xFm0NoX9Ro+ENP6tPhe6e4OI9Gtqtz5Yql0z31NEw+CbXNlkAPOMF1aaYwRYVDAN
 yr0Q==
X-Gm-Message-State: AC+VfDy+OszXHdxY8PM+tBaG+g6Gdjbr8fA9CwyH0U0C3B9eebgkGigs
 N0/h5WTUxVZRILuA7up554yoBlWQ9emunNQa4DCINVzRrSHJY8UKJYpsH33WTNOLiKTuGdTiTSh
 jKG3Di1Yp6Las2ac=
X-Received: by 2002:adf:e0c5:0:b0:30a:a193:3987 with SMTP id
 m5-20020adfe0c5000000b0030aa1933987mr4747823wri.30.1685273373576; 
 Sun, 28 May 2023 04:29:33 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5nRmetfr4eg+6ku2aqOx8tnmJCI1OSb1KuFsFZBpGsOhbH7nlNQ+QLS8752JhyfXrrjVNQlA==
X-Received: by 2002:adf:e0c5:0:b0:30a:a193:3987 with SMTP id
 m5-20020adfe0c5000000b0030aa1933987mr4747816wri.30.1685273373314; 
 Sun, 28 May 2023 04:29:33 -0700 (PDT)
Received: from redhat.com ([2.52.146.27]) by smtp.gmail.com with ESMTPSA id
 v10-20020adfe28a000000b003063a1cdaf2sm10394324wri.48.2023.05.28.04.29.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 May 2023 04:29:32 -0700 (PDT)
Date: Sun, 28 May 2023 07:29:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: zhenwei pi <pizhenwei@bytedance.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, arei.gonglei@huawei.com,
 qemu-devel@nongnu.org
Subject: Re: Re: [PATCH] cryptodev: fix memory leak during stats query
Message-ID: <20230528072913-mutt-send-email-mst@kernel.org>
References: <20230503115437.262469-1-pizhenwei@bytedance.com>
 <CAFEAcA-rXQwFAj9pz9vtqdk3i5KYDcf_w2-s78VtF7NYQJvsvw@mail.gmail.com>
 <6c5bb6a2-9177-ee9f-be7d-7394e8e54ff0@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c5bb6a2-9177-ee9f-be7d-7394e8e54ff0@bytedance.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.164,
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

On Fri, May 26, 2023 at 04:34:21PM +0800, zhenwei pi wrote:
> 
> 
> On 5/3/23 20:59, Peter Maydell wrote:
> > On Wed, 3 May 2023 at 12:54, zhenwei pi <pizhenwei@bytedance.com> wrote:
> > > 
> > > object_get_canonical_path already returns newly allocated memory, this
> > > means no additional g_strdup required. Remove g_strdup to avoid memory
> > > leak.
> > > 
> > > Fixes: Coverity CID 1508074
> > > Fixes: f2b901098 ("cryptodev: Support query-stats QMP command")
> > > Cc: Peter Maydell <peter.maydell@linaro.org>
> > > Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> > > ---
> > 
> > Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> > 
> > thanks
> > -- PMM
> 
> Hi, Michael
> 
> This patch has been ignored, could you please merge this in next PR?
> 
> -- 
> zhenwei pi
> 

I don't know why - didn't have it in my inbox. Tagged now, thanks!


