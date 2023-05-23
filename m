Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5DC70DDB9
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 15:41:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1SG6-0004GE-Dv; Tue, 23 May 2023 09:41:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q1SG0-0004Fw-KZ
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:40:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q1SFz-0008Hp-4A
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:40:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684849254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/7jZ3dVDf/ymWlxLEEpXjfG5NsVuVZuU4Ip7/FKTBU8=;
 b=hIQiJiNzuNsbDMmLBy7+htQf0MRUeSokUf+N7GU5/XAiMnhmTkVt5sfTuhQbEXzPB0abGD
 Bq5uox5ajkx2EI1FspYKmg2oY0xIKxBkyklJ6gI4HTYAhcTOqSzP/nTbWfRioeNLOSnklj
 ouMr8CdTjKBuc2EvguRG9G5MGFSBtsY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-cEPTeHF5Pmu8a_F4Dc3Uyg-1; Tue, 23 May 2023 09:40:50 -0400
X-MC-Unique: cEPTeHF5Pmu8a_F4Dc3Uyg-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-3f6b1853e80so3289101cf.1
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:40:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684849250; x=1687441250;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/7jZ3dVDf/ymWlxLEEpXjfG5NsVuVZuU4Ip7/FKTBU8=;
 b=i/D4itrOGP8s4dhkdhmcJeXA/m7pG+tiwxyp+06sWOHWNQC9xZxM86xjwCoTDijhy7
 tBLLQYQZVBrob0vuNAuVWJ2Rx4c7LVXfKSefPu/Xq8a8BByWjATfAOWCqWVWFtdK9d+H
 voEQ0BUybpuZm6/F/S+IMhF2jxJ7z56qpjoe1u5onuvM+eTzoI1ALURJ6QnZ9NDjaeRI
 2nL7hKpC8+RDb42ec1o8e7+NnmlqZ3T63sADR+C9qAyXhz8XISiqQVgKHdt3L/dcw1kk
 F7X90jALp/VbgzR7CX4Rqvb5p2XZJMGTqUyBYzir0ccUYpqE/mXzkHh1UbmDkE3EKU+u
 a/XA==
X-Gm-Message-State: AC+VfDwECaPvY9My82vEk/Deb1TpcOTrT1tvCpBGCCDmpmyPspVn9911
 UdAI1T8g01jPwdOXKOkvgYc6Cl4gR+WKulqMaS68EKhkk/1ixqrrr9VNhBFu6bWJbpmgZ3J6Je5
 moSTsdHWuGQuoid8=
X-Received: by 2002:a05:622a:104d:b0:3f6:aacf:5853 with SMTP id
 f13-20020a05622a104d00b003f6aacf5853mr11993960qte.3.1684849250230; 
 Tue, 23 May 2023 06:40:50 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6djdOr1sDhXSIywAPrfs+Y3yazi14h4oIF3XfYXR72jcmXsdBBwgURzOE17EEmCt5dlJApaQ==
X-Received: by 2002:a05:622a:104d:b0:3f6:aacf:5853 with SMTP id
 f13-20020a05622a104d00b003f6aacf5853mr11993936qte.3.1684849249920; 
 Tue, 23 May 2023 06:40:49 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca.
 [70.24.86.62]) by smtp.gmail.com with ESMTPSA id
 r11-20020ac85e8b000000b003f6be76a5c1sm237809qtx.6.2023.05.23.06.40.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 06:40:49 -0700 (PDT)
Date: Tue, 23 May 2023 09:40:48 -0400
From: Peter Xu <peterx@redhat.com>
To: "Wang, Wei W" <wei.w.wang@intel.com>
Cc: "quintela@redhat.com" <quintela@redhat.com>,
 "Wang, Lei4" <lei4.wang@intel.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v1] migration: fail the cap check if it requires the use
 of deferred incoming
Message-ID: <ZGzCYMRWa7sW9xAv@x1n>
References: <20230518160026.57414-1-wei.w.wang@intel.com>
 <ZGZ6Yqx2+dOp+Q73@x1n>
 <DS0PR11MB637350354B0285ABF3FA1BD9DC7C9@DS0PR11MB6373.namprd11.prod.outlook.com>
 <ZGeWF4lzBldLLH/y@x1n> <ZGeW3R5McptUueJF@x1n>
 <DS0PR11MB63736A4AE4A624D2B9EFD19DDC7D9@DS0PR11MB6373.namprd11.prod.outlook.com>
 <ZGv8adigFYpLD89k@x1n>
 <DS0PR11MB63737B09D72A735EC21F3C41DC409@DS0PR11MB6373.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DS0PR11MB63737B09D72A735EC21F3C41DC409@DS0PR11MB6373.namprd11.prod.outlook.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, May 23, 2023 at 01:44:03AM +0000, Wang, Wei W wrote:
> On Tuesday, May 23, 2023 7:36 AM, Peter Xu wrote:
> > > > We may also want to trap the channel setups on num:
> > > >
> > > > migrate_params_test_apply():
> > > >
> > > >     if (params->has_multifd_channels) {
> > > >         dest->multifd_channels = params->multifd_channels;
> > > >     }
> > >
> > > Didn’t get this one. What do you want to add to above?
> > 
> > I meant after listen() is called with an explicit number in this case, should we
> > disallow changing of multifd number of channels?
> 
> Got you, thanks. That seems unnecessary to me, as the cap setting is required
> for the use of multifd and patching there already achieves below what we want:
> - users get the error message when deferred -incoming isn’t used;
> - fail the cap setting for multifd, meaning that multifd won't be used (i.e.
> no place that will care about multifd_channels).

It's about whether we want to protect e.g. below steps:

1. start dest qemu with -incoming defer
2. "migrate-set-capabilities" to enable multifd
3. "migrate-incoming xxx" to setup the sockets
4. "migrate-set-parameters" to setup the num of multifd   <--- will be invalid here

Would that still be a problem that falls into the same category of what
this patch wants to protect qemu from?

Thanks,

-- 
Peter Xu


