Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 746FB835B76
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 08:15:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRoWR-0003xA-8h; Mon, 22 Jan 2024 02:15:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rRoWP-0003wd-KQ
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 02:15:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rRoWN-00052b-MZ
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 02:15:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705907703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1WU+NUYK0fAZkUQe6anybytPlskJ5sOK83wXpcLXY6Q=;
 b=GJvwTqypHX6hj9GMhTsnyp56inVmSpNBHlWOw04lMUJ6dEb3P1YhtrI8TGk7yXJ0/oA62y
 U1HtFNHOlFUdtfHSVW/Mxrhn5iQ/lR67VEFrXqpVCcisfjoxlPgNVtosk3CM05LYsf1a2o
 C5f8i8dCPBV/F7rfbDQ+nb1MfLnvlyk=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-2_hmWpNnONWLm-kc1gld5w-1; Mon, 22 Jan 2024 02:14:59 -0500
X-MC-Unique: 2_hmWpNnONWLm-kc1gld5w-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-6d99a379dacso911465b3a.1
 for <qemu-devel@nongnu.org>; Sun, 21 Jan 2024 23:14:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705907698; x=1706512498;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1WU+NUYK0fAZkUQe6anybytPlskJ5sOK83wXpcLXY6Q=;
 b=PkW8361c6IOERdcmtu8ud0OKs+3fFLCzxNi9O8Erx83LRqW364m01CCwOyytgR7CCS
 0Lp0V4s3eKhC1pH8N+4mQFkD0KmyiT8GCSynqS0MFHmeXTV3U+tBmYXKEs3FxBAu3fyj
 3lmPg2k6oLMbOQ5JbrJL9kq20d7r2QjTu9r9iqkEP/wTxaIqq4dgnJ20ZYC+/JnTnIh9
 gf/c95cRbLYkLiZNWtKLUoxgDLJEHGIyHK5yl6E5PJH28Vmr2Xg93TeUvqvbHqUYO3Pu
 AN8QC5VGqMqLmRTq+x8DHQVRlh60m8TrBuOtaer0eXBlRZJ4WPVLFDamtoxrx7HxCCLo
 IGkA==
X-Gm-Message-State: AOJu0YxmNr7UVuULHogsgM3VALbWniwlGgWGyMqlKNkCb9bFLw8j9cJB
 yaCYmFZrMyaMxxOuefKWPVwv+QRbqcwcNoA2vm3Q7cLgvv83OhhK6Av9iV4uP3t2P1i+dkNUx29
 R/KpGekUQQgmMaUM9MVANdwPxN42KpceLsK5OTIAiJMmIXe8dmMHA
X-Received: by 2002:aa7:9f4a:0:b0:6d9:edd1:4ede with SMTP id
 h10-20020aa79f4a000000b006d9edd14edemr7503400pfr.2.1705907697963; 
 Sun, 21 Jan 2024 23:14:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGwDLaWkXPgu1VjHpRiUbgsTxoumYSUG12yWgk5Ss6fnVB4MmVChDF4hPJJzKRy/BbZhEbnnQ==
X-Received: by 2002:aa7:9f4a:0:b0:6d9:edd1:4ede with SMTP id
 h10-20020aa79f4a000000b006d9edd14edemr7503391pfr.2.1705907697629; 
 Sun, 21 Jan 2024 23:14:57 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 s16-20020a639250000000b005c200b11b77sm7821609pgn.86.2024.01.21.23.14.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jan 2024 23:14:57 -0800 (PST)
Date: Mon, 22 Jan 2024 15:14:50 +0800
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Shlomo Pongratz <shlomopongratz@gmail.com>, qemu-devel@nongnu.org,
 andrew.sminov@gmail.com, peter.maydell@linaro.com,
 shlomop@pliops.com, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v3] Handle wrap around in limit calculation
Message-ID: <Za4V6rjEmk9fRsQX@x1n>
References: <20240121164754.47367-1-shlomop@pliops.com>
 <98ede7dd-b254-43aa-bf7d-f5d90494b8c9@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98ede7dd-b254-43aa-bf7d-f5d90494b8c9@linaro.org>
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

On Mon, Jan 22, 2024 at 12:17:24AM +0100, Philippe Mathieu-Daudé wrote:
> > @@ -560,7 +569,7 @@ static const VMStateDescription vmstate_designware_pcie_viewport = {
> >       .fields = (const VMStateField[]) {
> >           VMSTATE_UINT64(base, DesignwarePCIEViewport),
> >           VMSTATE_UINT64(target, DesignwarePCIEViewport),
> > -        VMSTATE_UINT32(limit, DesignwarePCIEViewport),
> > +        VMSTATE_UINT64(limit, DesignwarePCIEViewport),
> 
> Unfortunately this breaks the migration stream. I'm not sure
> what is the best way to deal with it (Cc'ing migration
> maintainers).

My understanding is that we can have at least two ways to do this, one
relying on machine type properties, the other one can be VMSD versioning.
Frankly I don't have a solid mind either on which is the best approach.

I never had a talk with either Juan / Dave before on this, but my
understanding is that VMSD versioning is just less-flexible, because it
doesn't support backward migrations (only forward).  While machine-type
property based solution can support both (forward + backward).

I decided to draft a doc update for this, to put my thoughts here:

https://lore.kernel.org/qemu-devel/20240122070600.16681-1-peterx@redhat.com

It can be seen as a reference, or review comments also welcomed.

This device seems to be only supported by CONFIG_FSL_IMX7.  Maybe vmsd
versioning would be good enough here, then?  If so, instead of
VMSTATE_UINT64(), we may want a new VMSTATE_UINT32_V() with a boosted
version.

Thanks,

-- 
Peter Xu


