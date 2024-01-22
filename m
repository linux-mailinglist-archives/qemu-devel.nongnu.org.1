Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC39583593E
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 03:09:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRjix-00021m-2a; Sun, 21 Jan 2024 21:07:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rRjiv-00021K-ET
 for qemu-devel@nongnu.org; Sun, 21 Jan 2024 21:07:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rRjiq-0001eK-Tp
 for qemu-devel@nongnu.org; Sun, 21 Jan 2024 21:07:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705889255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uS881xRTIVBsQQ6OGcIyp+i0nD6S/054cqvmGquC04w=;
 b=ddbjZ2QbVv749xMKn6ZcT7ze7qkbrMYeS3Zugg1Upj55OrsQ8X5Nh9vQrZyoQ05PCzWB0L
 b0v/F/Jfq6LNZJbeKNsr4rju9rQ9fRx0rxtxhtqfTTXR2P3KcuFySc7vNWY0ZyCl77B6QO
 8d0+UDc4yFaQ3GZyn6yE89pQy41yqis=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-cg1Dy2MFOCqCn0fIjtnbhw-1; Sun, 21 Jan 2024 21:07:33 -0500
X-MC-Unique: cg1Dy2MFOCqCn0fIjtnbhw-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-5cfccde4a54so115599a12.1
 for <qemu-devel@nongnu.org>; Sun, 21 Jan 2024 18:07:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705889252; x=1706494052;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uS881xRTIVBsQQ6OGcIyp+i0nD6S/054cqvmGquC04w=;
 b=H9oQOdGsS72ZvxHLpWpkLE6tML0b3o0w5Zg0TJDQC9ufzTlNiP1zWPdxhTozucVeMY
 hmp0SQVCi7gS+83GJ2Qt77TU4G+G8l5NJfYf0cWvorlUUXYfc9GL+Yu+dfNxRym+jIT5
 YVmRVGK7NcfVBpwapOJCgSnlaF3EkgtcdFUB6UfPPpLu5AlZxwdQJcwZlzEpL1EbsO5G
 Cs6yqJWkuXGXXg3izuCorhxKNIO5kz0lYMeVagHT8Eib0QyG8Qet+B+xC7hV1IcvPhuo
 k6Z08I62F0Ysn9i/9xJM9g6ZTx/m+pivUjweQOjV0GnsvCTkK82c7AgmwXIsCoSLMnFz
 yxyw==
X-Gm-Message-State: AOJu0YxyKGbIqzNMSm+8cCC5t/8ZzBe7eRNVDADiaXO5QY8rY/1vTDif
 lqtd1czPYwsdHPtExhk4PFVsEFkC/oeOgT9r4wsoCd0AsFmA4Th+GeKxvisRb4qEpLSlLZ6cO5S
 DQh9bUtptiMSMjdfi3TmgN3h5g1hSCWRDaj9A10LZ7wiGsFmmrmGJ
X-Received: by 2002:a05:6a20:d398:b0:19b:1d4a:b94c with SMTP id
 iq24-20020a056a20d39800b0019b1d4ab94cmr9545642pzb.2.1705889252448; 
 Sun, 21 Jan 2024 18:07:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE9bUkzjL9S+AwS9aw6kKglV7w/7J8z117dkG4z3JA5lZ4QtQFM6bLNW76T7BJreyxPj/NYsA==
X-Received: by 2002:a05:6a20:d398:b0:19b:1d4a:b94c with SMTP id
 iq24-20020a056a20d39800b0019b1d4ab94cmr9545625pzb.2.1705889252124; 
 Sun, 21 Jan 2024 18:07:32 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 a28-20020aa78e9c000000b006d9bdc0f765sm8590910pfr.53.2024.01.21.18.07.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jan 2024 18:07:31 -0800 (PST)
Date: Mon, 22 Jan 2024 10:06:33 +0800
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH 0/5] buses: switch to 3-phase-reset
Message-ID: <Za3NqdR2w_4bdIew@x1n>
References: <20240119163512.3810301-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240119163512.3810301-1-peter.maydell@linaro.org>
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

Hi, Peter,

On Fri, Jan 19, 2024 at 04:35:07PM +0000, Peter Maydell wrote:
> I wrote this ages ago and recently picked it back up because of a
> recent PCI related reset ordering problem noted by Peter Xu.  I'm not
> sure if this patchset is necessary as a part of fixing that ordering
> problem (it might even be possible now to have the intel_iommu device
> use 3-phase reset and put the relevant parts of its reset into the
> 'exit' phase), but either way we really ought to do this cleanup
> to reduce the amount of legacy/transitional handling we have.

The VFIO issue I was working on may not directly benefit from this series
iiuc, as it's more of an special ordering on both (1) VFIO special case
reset path using qemu_register_reset(), and (2) VT-d device is not put at
the right place in the QOM hierachy [1].

Said that, thanks a lot for posting the patches; they all look reasonable
and good cleanups to the reset infrastructure, afaict.

[1] https://lore.kernel.org/r/ZapYii9nr5Tj9ClE@x1n

-- 
Peter Xu


