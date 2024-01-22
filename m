Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BE1835F84
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 11:24:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRrTD-0001hJ-KF; Mon, 22 Jan 2024 05:23:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rRrTA-0001gx-J8
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 05:23:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rRrT8-0002q4-QU
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 05:23:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705919033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/IH56VGY8kZV2Gpu2O6Q+MRp3KlgfvEUnTqSj12pUqM=;
 b=NRBK4B5rh+0CsGR1dNT/ndvSwgYRaArlap8kR1Nk3i1e+w+FfdDr1RJW4rEQostHahPb5E
 c+IPk4NqDb0GjNMGutsD4Q7xOB2FVwO/Flbh7lUeP3Y8wIFpOq8V/Ofq9pOVQ5O0FV//Ep
 D8uRyulkfg1uvsViNBGPUjfKqkfNLvc=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-YEFWTG8KON2opyYJ3QWJQA-1; Mon, 22 Jan 2024 05:23:51 -0500
X-MC-Unique: YEFWTG8KON2opyYJ3QWJQA-1
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-6da5a9defd5so1009696b3a.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 02:23:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705919031; x=1706523831;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/IH56VGY8kZV2Gpu2O6Q+MRp3KlgfvEUnTqSj12pUqM=;
 b=tx0QtCG+zqofEej3DB7xKLiRXTR10WGHqKWJcwhRNHAe6VlzX533Ini02WONSZjCFc
 K9Iz8JdwyHhoCcbsTn7b3tR09azn90Drf33HFAHv2tKmOHf9rIr4Vwg/rJkB3W0uaSaB
 A6ob6T3fvoaBkMMp1soO7NUlYIDeskILAsXoOfDJYFeY4ViHgwy4hVSi0LVmGXXCvfNK
 7VT81JQsS7Lipd1Qs7Ufx+Hj3FZW4cYcf+rM4pGTEURZ8XnA10qpFh6uTanCSEKJKbsG
 J34Y+6y7VG2MOHDBtaKIzGjle81jVoOt3ideAQilSp9VAJfxYqSEsMz4E6/UddAgk4h3
 LuYQ==
X-Gm-Message-State: AOJu0YxZyqwNXI2Wm2J3xOFTrvL6FLM1PEFfuQYJUrptSt88yaZ0VF2h
 dHitnrL3jrzBP0OUxzQvUgKDW/Vp3vzpcupBVK9eDEpkdbrdpvz6wpPKoeA3nCmQuEcEwaw3BUX
 5p3iIYCev8TTpv9RXdLWprGG2uZpS/OuslzdwlP+Visin2NkXH9DZ
X-Received: by 2002:a62:6204:0:b0:6d9:b7b8:133f with SMTP id
 w4-20020a626204000000b006d9b7b8133fmr8053619pfb.1.1705919030845; 
 Mon, 22 Jan 2024 02:23:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjN/31Aui0yxEB7nWL8EBxZ04c0p+tCtkagndTg8IzuQ4l3Q6+GsL7tC0DkDDR1U6LRevu0Q==
X-Received: by 2002:a62:6204:0:b0:6d9:b7b8:133f with SMTP id
 w4-20020a626204000000b006d9b7b8133fmr8053613pfb.1.1705919030535; 
 Mon, 22 Jan 2024 02:23:50 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 r1-20020a62e401000000b006d9fd64fdcasm9278543pfh.37.2024.01.22.02.23.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 02:23:50 -0800 (PST)
Date: Mon, 22 Jan 2024 18:23:41 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v4 0/3] migration & CI: Add a CI job for migration compat
 testing
Message-ID: <Za5CLca2c6kYDpR2@x1n>
References: <20240118164951.30350-1-farosas@suse.de> <Zao8whp3WCWOPb-9@x1n>
 <87v87pzdck.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87v87pzdck.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.287,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Fri, Jan 19, 2024 at 10:01:31AM -0300, Fabiano Rosas wrote:
> I mentioned this at the bottom of the commit message for patch 2/3. You
> need to push your tags. Otherwise your fork on gitlab won't have
> knowledge of v8.2.0.

Oops, my fault.  Yeah it works now; I queued this into staging.

Thanks,

-- 
Peter Xu


