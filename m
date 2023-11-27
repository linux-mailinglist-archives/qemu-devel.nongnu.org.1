Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AAA27FA33E
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 15:43:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7con-0000fP-AI; Mon, 27 Nov 2023 09:42:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r7cok-0000eJ-1R
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 09:42:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r7coi-0002Qt-KQ
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 09:42:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701096151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RTgpGaIH0yt5WRc0ini5auXF5C5RV39vT6brzeGQsug=;
 b=VZ/BMg3/THIuwqFKXpfzan9WLaMP1s7xujPtb3+9oLzDL0lCo62SuPDKbmyzOoJixWAJ7D
 8LGWVlo45PTcN7b4KfBm9kCbN8lsbqLrmRpPhpdDhCdlkvytcDv1dD2VNhjLbQAxfwfJif
 kyTwM6GkxS+bq9GIWwFR+GaJGaF1w/I=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-MTpxpX0kN-C_Ae10I2RhAQ-1; Mon, 27 Nov 2023 09:42:30 -0500
X-MC-Unique: MTpxpX0kN-C_Ae10I2RhAQ-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-423a6c92800so3824821cf.1
 for <qemu-devel@nongnu.org>; Mon, 27 Nov 2023 06:42:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701096149; x=1701700949;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RTgpGaIH0yt5WRc0ini5auXF5C5RV39vT6brzeGQsug=;
 b=pRPj0O8dfUe2SV4SXpjBRAfBwuWhDIpQWt0AiDZWb0hdAeC52qFOSOQQQn8zANI89J
 c+8DhHJd/LTbMvUZ78Yy2icvGyFO7TDrQQLIPNLI1BMhUagKmBdShlAfRSIWi/lbOoGw
 pfLvevmg4XRmKcAb+pTDL8vqQKW12Zxtb47cgjHKbWo/3j3UKIZm/3LR2Pn6qgxWZIaA
 LmOwLa66vNHWNaJXOL+ZuTdV/c6EuRJxUswE4eMHVLzEI3JHzd8UYb1mXCxF4tRuDnQB
 oqLI1WFaUjx+sqeDRi4hlG8nukQ6bdj/OVJaTlyXoL55SLCUg9K1m/gJtJaMLzT1q072
 tDZw==
X-Gm-Message-State: AOJu0YwG//G+HKw6K+tcL82FWOfhHgA+m7LZaI9XxFYSTwEifGh0kB1R
 XgcmmVLWdWr/1ZT4l8szzFyShjPAQ6lRnT8tXQcdbif+dzixAgMF3Rqa0kDLaDiT+NpKMsF1i49
 +thFq1DshZC9e3sY=
X-Received: by 2002:a05:6214:2e04:b0:67a:52c7:f444 with SMTP id
 mx4-20020a0562142e0400b0067a52c7f444mr911030qvb.6.1701096149640; 
 Mon, 27 Nov 2023 06:42:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGB71GHhoFrkDpilzJCsXBaUstsVURLze2Ab6w/ypWJWBaj785z71ypmm8KsnngWsYbR/KWDA==
X-Received: by 2002:a05:6214:2e04:b0:67a:52c7:f444 with SMTP id
 mx4-20020a0562142e0400b0067a52c7f444mr911002qvb.6.1701096149224; 
 Mon, 27 Nov 2023 06:42:29 -0800 (PST)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 q10-20020a0cfa0a000000b0067a28752199sm2439595qvn.10.2023.11.27.06.42.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 06:42:28 -0800 (PST)
Date: Mon, 27 Nov 2023 09:42:27 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v1 1/7] migration/multifd: Remove
 MultiFDPages_t::packet_num
Message-ID: <ZWSq0y00S5LcD5dB@x1n>
References: <20231124161432.3515-1-farosas@suse.de>
 <20231124161432.3515-2-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231124161432.3515-2-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Nov 24, 2023 at 01:14:26PM -0300, Fabiano Rosas wrote:
> This was introduced by commit 34c55a94b1 ("migration: Create multipage
> support") and never used.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


