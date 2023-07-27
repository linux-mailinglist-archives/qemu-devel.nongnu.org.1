Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3880D76554C
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 15:44:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP0gv-0001yf-Sq; Thu, 27 Jul 2023 09:06:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qP0gr-0001vY-RB
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 09:06:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qP0gq-0004sb-70
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 09:06:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690463159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HrILHOUsBYF8bhAlbmvO9P9RdB2fu0GKMiM6+oi/5T4=;
 b=CUS/yCUH6UdSuzzAqQosQGv29wpTmDr2YV0J/u+BRPI0dg58CkGjT9cGKku9vkIcERzd/I
 MJ8HJfFdfJdvSu7KHE6xSygIbSCNu22W1T8aHeJ8MlMqcoIm/qXK9VqNl1Cvbp77aoM/TH
 69bWGdaDiwsxhyiRdp+JAQubHgmOLBE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-uAMkAVaRNMuQVBBEsghKVg-1; Thu, 27 Jul 2023 09:05:57 -0400
X-MC-Unique: uAMkAVaRNMuQVBBEsghKVg-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-50a16ab50e6so559138a12.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 06:05:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690463156; x=1691067956;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HrILHOUsBYF8bhAlbmvO9P9RdB2fu0GKMiM6+oi/5T4=;
 b=V/mSBl2htGY3JmD90t2PMWDf313oSV4IT2l0L5bgkFoC68Q3j6TZhmCYZp/KCh9DRn
 m1gPZoiHyEV4d0vZw7OFoMVPAMRLEWcOBzVcu8LmgtfDtLGHU8eVPkkwG1YmvhuphS6l
 0uNP0T1U8slmrcWNx5cw1p0lojAi1Mmlj9N1YcvZ+71LKi8jte9th/iDlsxCupjnPXVV
 xNKD9wLG+WwVO4Aad7TQnX/vAxUynaJgVTHglvB99NlTGBs5inlQciwXBCR2dw7buxdx
 6cVgU3hUYbPM9TRYsGJEmc/2S2Ae0Jtovr61nDHNZCq5gdsrzHedvM7HQRCw1qmWDsT8
 RzCA==
X-Gm-Message-State: ABy/qLbiTkH4OqR/BTJ0yngf6IVSgtvcFo1frcCH75mf9jFo07Beuyaa
 7JpTdBdo6dQxb/HkCp6+rNb418+hb5Q1GQLYu0yAO32UOml9wH0Ex4GofjhAunBjl6MjnJ66LlE
 8drxsMjMH+ArZMHA=
X-Received: by 2002:a17:906:1c9:b0:99b:8ed2:8ff with SMTP id
 9-20020a17090601c900b0099b8ed208ffmr1976146ejj.1.1690463156630; 
 Thu, 27 Jul 2023 06:05:56 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFYnMKbM5iydaNuA6NaVHpoEVl+2QPet4osQbpwUoJWQBVyXeEUaMaGsWUnaKS08Wd3flvZ+A==
X-Received: by 2002:a17:906:1c9:b0:99b:8ed2:8ff with SMTP id
 9-20020a17090601c900b0099b8ed208ffmr1976128ejj.1.1690463156346; 
 Thu, 27 Jul 2023 06:05:56 -0700 (PDT)
Received: from redhat.com ([2.52.14.22]) by smtp.gmail.com with ESMTPSA id
 e6-20020a1709067e0600b00992b66e54e9sm735719ejr.214.2023.07.27.06.05.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jul 2023 06:05:53 -0700 (PDT)
Date: Thu, 27 Jul 2023 09:05:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, yvugenfi@redhat.com, si-wei.liu@oracle.com,
 Jason Wang <jasowang@redhat.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Shannon Nelson <snelson@pensando.io>
Subject: Re: [RFC PATCH 00/12] Prefer to use SVQ to stall dataplane at NIC
 state restore through CVQ
Message-ID: <20230727090312-mutt-send-email-mst@kernel.org>
References: <20230720181459.607008-1-eperezma@redhat.com>
 <CAJaqyWdkyX9Ha-kd+haqEpfXfpVhSLmRa5hkZZGkvZjrD4Ketg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJaqyWdkyX9Ha-kd+haqEpfXfpVhSLmRa5hkZZGkvZjrD4Ketg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jul 21, 2023 at 08:48:02AM +0200, Eugenio Perez Martin wrote:
> * Leave _F_RING_RESET to be added on top, as the semantics are not
> implemented in vDPA at the moment.

We really need _F_RING_RESET in vdpa too though.
You did code it up already - why do you want to leave
it out?

-- 
MST


