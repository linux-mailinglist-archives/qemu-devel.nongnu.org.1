Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C827AF1D3
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 19:40:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlC1K-0007db-Fc; Tue, 26 Sep 2023 13:38:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qlC1I-0007dM-6l
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 13:38:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qlC1G-00075f-EB
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 13:38:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695749925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ob+RmI8Q12nvsp2+PERyB7D/LCEmXW9jezCX5tQhu6c=;
 b=FJa/acwA+vUI8KwBiAG87mJyCNHpVtMFhUTBm/khrrtjTsANbX4Nlfjbp0BP+BMxPXQ4YD
 fd036dnd+G6SEn89sHPpfD7obRYFWGKNC2v1ZZw0/vlKTgRxxwntrhxkIfWJisJRfyIXX9
 CvBZ6ET6X492B9bOSgcROEX0+ZUgC5Q=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-VXryL8jvNyWRfVKmTBhpFw-1; Tue, 26 Sep 2023 13:38:43 -0400
X-MC-Unique: VXryL8jvNyWRfVKmTBhpFw-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5033420dd31so13716750e87.1
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 10:38:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695749922; x=1696354722;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ob+RmI8Q12nvsp2+PERyB7D/LCEmXW9jezCX5tQhu6c=;
 b=BjcxYWxiOAbuNZh/sdNMS0prX9xcZzuTETzvf1pZsUsBXEnJeL72bMTM6U87jy3hEJ
 Up8rrY/1jMcf5f6oITeUNzQp5rD6vOzOIAgEM+8QYn2UWPJhYLlt4/CPQMoKJWJ6QykS
 /LfNymZYg9MN1IC2bYD28WDstkym6bMYhoyiWJ6N/JNiBqNcYtfpFaT7TCGsGXgUOOsn
 zvOvS5q9Q7ca0tJl7bJUp8Q3pZ36RwxFcKLksJ27ghWavm/WwsWZ2re9hZ5EU93a8igF
 zaPwrhqPN65aWEqtC6qogYX4apNMI2YR+J3sTLqSm4A4inQgkQ3TWcvnLNGjnknrbe0K
 MdzQ==
X-Gm-Message-State: AOJu0YxMitIXpg1Q/bCw/VVGBkeToqS+vX6kdQtgyOiuwJhubQ1EKBR8
 6+wJ9U5iBxtwy7CaHZAudHXjI/D4I3FeADL08pQ195ntDQDzgt26VemlIEftNbzPFsC9SPZ/sQ2
 evZH0RkH6sM4a6AQ=
X-Received: by 2002:ac2:4f07:0:b0:4fb:caed:95c3 with SMTP id
 k7-20020ac24f07000000b004fbcaed95c3mr9615162lfr.53.1695749921986; 
 Tue, 26 Sep 2023 10:38:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHULvUT+KD+M+sPxZabHHFvQG6VSCDIp0hvF2mESaeaKAtqtqlyOT5V39jUPCTojD8+w49ddw==
X-Received: by 2002:ac2:4f07:0:b0:4fb:caed:95c3 with SMTP id
 k7-20020ac24f07000000b004fbcaed95c3mr9615141lfr.53.1695749921636; 
 Tue, 26 Sep 2023 10:38:41 -0700 (PDT)
Received: from redhat.com ([2.52.31.177]) by smtp.gmail.com with ESMTPSA id
 w22-20020a056402071600b0052e1783ab25sm7013064edx.70.2023.09.26.10.38.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 10:38:40 -0700 (PDT)
Date: Tue, 26 Sep 2023 13:38:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Salil Mehta <salil.mehta@huawei.com>
Cc: xianglai li <lixianglai@loongson.cn>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Bernhard Beschow <shentey@gmail.com>, Salil Mehta <salil.mehta@opnsrc.net>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Song Gao <gaosong@loongson.cn>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 "wangyanan (Y)" <wangyanan55@huawei.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Bibo Mao <maobibo@loongson.cn>
Subject: Re: [PATCH v3 2/7] Update CPUs AML with cpu-(ctrl)dev change
Message-ID: <20230926133530-mutt-send-email-mst@kernel.org>
References: <cover.1695697701.git.lixianglai@loongson.cn>
 <c2ab409710f5e0f0346727b47aaabd14537d45b8.1695697701.git.lixianglai@loongson.cn>
 <17a09b8ab65542be8561cb0480dae6bd@huawei.com>
 <20230926071055-mutt-send-email-mst@kernel.org>
 <4cc68780b63f47879d757fe604f37892@huawei.com>
 <20230926074945-mutt-send-email-mst@kernel.org>
 <54482e7486564d68926ded075ebe8c6f@huawei.com>
 <20230926080436-mutt-send-email-mst@kernel.org>
 <726b4f44a38e4ee8b476ab6130e29b13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <726b4f44a38e4ee8b476ab6130e29b13@huawei.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Sep 26, 2023 at 03:52:48PM +0000, Salil Mehta wrote:
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Tuesday, September 26, 2023 1:07 PM
> > To: Salil Mehta <salil.mehta@huawei.com>
> > Cc: xianglai li <lixianglai@loongson.cn>; qemu-devel@nongnu.org; Bernhard
> > Beschow <shentey@gmail.com>; Salil Mehta <salil.mehta@opnsrc.net>; Xiaojuan
> > Yang <yangxiaojuan@loongson.cn>; Song Gao <gaosong@loongson.cn>; Igor
> > Mammedov <imammedo@redhat.com>; Ani Sinha <anisinha@redhat.com>; Paolo
> > Bonzini <pbonzini@redhat.com>; Richard Henderson
> > <richard.henderson@linaro.org>; Eduardo Habkost <eduardo@habkost.net>;
> > Marcel Apfelbaum <marcel.apfelbaum@gmail.com>; Philippe Mathieu-Daudé
> > <philmd@linaro.org>; wangyanan (Y) <wangyanan55@huawei.com>; Daniel P.
> > Berrangé <berrange@redhat.com>; Peter Xu <peterx@redhat.com>; David
> > Hildenbrand <david@redhat.com>; Bibo Mao <maobibo@loongson.cn>
> > Subject: Re: [PATCH v3 2/7] Update CPUs AML with cpu-(ctrl)dev change
> > 
> > On Tue, Sep 26, 2023 at 12:03:46PM +0000, Salil Mehta wrote:
> > > Sure, ARM patch-set follows exactly above rules.
> > >
> > 
> > 
> > Almost.
> > 
> > 	Co-developed-by: Salil Mehta <salil.mehta@huawei.com>
> > 	Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> > 	Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
> > 	Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> > 	Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> > 
> > You should drop your own Co-developed-by as well as multiple Signed-off-by.
> 
> 
> https://docs.kernel.org/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by
> 
> Reference: Co-developed-by: Pasting excerpt from above link:
> 
> "1. Standard sign-off procedure applies, i.e. the ordering of
>    Signed-off-by: tags should reflect the chronological history
>    of the patch insofar as possible, regardless of whether the
>   author is attributed via From: or Co-developed-by:.
> 2.Notably, the last Signed-off-by: must always be that of the
>   developer submitting the patch."
> 
> To be able to achieve 1. I have to put Co-developed-by: of
> mine at the top as I am the main author of the patch-set
> historically and have been continually driving the work.
> (It is a common rule even within the kernel to keep first
>  SOB that of the main author)

yes that is fine.

> Reference: Signed-off-by: Excerpt from above link:
> 
> " Any further SoBs (Signed-off-by:'s) following the author's
>  SoB are from people handling and transporting the patch, but
>  were not involved in its development. SoB chains should
>  reflect the real route a patch took as it was propagated to
>  the maintainers and ultimately to Linus, with the first SoB
>  entry signalling primary authorship of a single author."
> 
> 
> And since I am the person who is submitting the patches
> (which might or not be the same in future) I need to put
> my SOB in any case to be able to achieve 2.
> 
> This is to ensure primary author remains the first SOD/CDY.
> 
> 
> Thanks
> Salil.

I think you misunderstand what it says -
you don't need to repeat signatures many times.
you took the patches that were signed off by people A,B,C
and sent to me. Thus you do:

S.o.b: A
S.o.b: B
S.o.b: C
S.o.b: Salil Mehta

and I add:
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
and send to Linus.

-- 
MST`


