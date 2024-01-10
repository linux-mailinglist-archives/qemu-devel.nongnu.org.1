Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 755CF82925A
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 03:12:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNO3O-0006Le-Oy; Tue, 09 Jan 2024 21:10:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rNO3M-0006LG-Qp
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 21:10:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rNO3L-0003qp-33
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 21:10:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704852645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9iP0/FCVAu3kvCP6uYT8815s83Qg2bJNNdlzLoc/PM4=;
 b=aRCuCGFVcZQu6wCBwsbilDRbot0wyphwJyZFYKks4ypmAsXweQjOPqYtlmkfPdE7fod32T
 ZQdj4bEg1yXTCZG/dzBiAc24NNTmOv8RSuecVzqX5h+V5dSqqZ+WISujKvK1bH3AQhc1qf
 dkIGt44mQFmbPDHXbhjGZ48377RmJTU=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-TJRunBKMO7aoZu0O1COc5A-1; Tue, 09 Jan 2024 21:10:44 -0500
X-MC-Unique: TJRunBKMO7aoZu0O1COc5A-1
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-6d9b3a964a1so966184b3a.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 18:10:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704852643; x=1705457443;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9iP0/FCVAu3kvCP6uYT8815s83Qg2bJNNdlzLoc/PM4=;
 b=kDJlbL1fRV0uEzXYCk/I3Ke8gYySZJRLeTrKFc/8NCTimVNpYFzSy20DdSn8taDJVL
 kyZqDFR5BsuZpNlByfgnma4TeO7W5uPVCecsUlsNxSu102vPNFVn6FIR7HXIPg3TTgXx
 1tIgGXtHx3ewdad/FykEgT/ZanDE9kljCh1zmNuR/eTT01ozb7b/HRcCtlElrb6tg0kL
 xyjF2CVhdg3C5Rcwg81DXngHpF+yC3RfOcGqxEf6yBhxL5Qzdmq21OOhcqth8xdPimZQ
 9V63KJHNyEC/1DcT2rvpQCnogoFUTxs30I26fvJKCRu4mpibvrqXIZlBA6n44j8OYJxB
 2RdA==
X-Gm-Message-State: AOJu0YzZcL2WOuzcg9XGSe0FE9SDibn0oAKQVG8RCDQkLw3HTIJVoRKl
 7QXFNNo/A5DZ9zBnkLCHi7c6LlprP1UBzKRJypuOLcFVkZFwQzFsxMH+OhFS+HgBKAkHHzDC7fi
 aTXeAnQvCRv1X7vZYiA+e3FY=
X-Received: by 2002:a05:6a20:8427:b0:196:16b0:c554 with SMTP id
 c39-20020a056a20842700b0019616b0c554mr478192pzd.5.1704852643610; 
 Tue, 09 Jan 2024 18:10:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6hmCpj+QVqLUGGpkncR2Ii5RRDRkNQj3IfeOmu32zxy3836fDR9AZgFIeSEmNwJeEKfQHfg==
X-Received: by 2002:a05:6a20:8427:b0:196:16b0:c554 with SMTP id
 c39-20020a056a20842700b0019616b0c554mr478175pzd.5.1704852643313; 
 Tue, 09 Jan 2024 18:10:43 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 sz3-20020a17090b2d4300b0028afdb88d08sm183902pjb.23.2024.01.09.18.10.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jan 2024 18:10:43 -0800 (PST)
Date: Wed, 10 Jan 2024 10:10:32 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Bandan Das <bdas@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>
Subject: Re: [PATCH 05/10] docs/migration: Split "Debugging" and "Firmware"
Message-ID: <ZZ38mJDK2LF3dbTR@x1n>
References: <20240109064628.595453-1-peterx@redhat.com>
 <20240109064628.595453-6-peterx@redhat.com>
 <87sf36783b.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87sf36783b.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.493,
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

On Tue, Jan 09, 2024 at 02:03:04PM -0300, Fabiano Rosas wrote:
> peterx@redhat.com writes:
> 
> > From: Peter Xu <peterx@redhat.com>
> >
> > Move the two sections into a separate file called "best-practises.rst".
> 
> s/practises/practices/

Will fix, thanks.

-- 
Peter Xu


