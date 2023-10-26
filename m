Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B837D8990
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 22:16:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qw6lD-0002kt-7Z; Thu, 26 Oct 2023 16:15:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qw6lA-0002kX-Me
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 16:15:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qw6l9-0003Mu-AC
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 16:15:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698351314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kVip/AljdEYEWr5IoCBil+sKw8ew84bnCDt+5yH1ykQ=;
 b=K84gWSRqN/MHOF0t2v17+VC9F4nPcOqZX2DASAa3/LUUx4jc4YJ/KYdPnN7MASB1HEaMMz
 dTKm5xXUgtGpOCVl5JElY6DwaHz9jdKYRLOfHsAQ7Aofv0w948J6yc0yKTi8gOWaIdHV0D
 aNCB421Xss8IrdnqTjE97I3pS3ybZms=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-uA7TGnWkMDi0a1LhBWx4CQ-1; Thu, 26 Oct 2023 16:15:13 -0400
X-MC-Unique: uA7TGnWkMDi0a1LhBWx4CQ-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-66d2fdf80beso3345206d6.0
 for <qemu-devel@nongnu.org>; Thu, 26 Oct 2023 13:15:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698351312; x=1698956112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kVip/AljdEYEWr5IoCBil+sKw8ew84bnCDt+5yH1ykQ=;
 b=wKNRZ6fmV8LaCxCgO4fbPw49VtkrkhHz4/jQWKIrrFsZ5huA8bDtmf+CKNqcC9WkvY
 w8IaBFz4U8Qe8+gAi3fO/DSeYg77ySeOJpsgwsHUTJxlzg+OJC8iM1PlKWiiCu5al//p
 oBpzjmo6Yocjdoo3+QHdI3J2JkN1kugYuYd1JsuxgRYxrGiZAkV2w3OmcPLkNfwbG+sK
 8DNuqC3JIDGdqRFoCvwK2g1J4+7t5386LsytBmvG3SpO7iZgf0QkLsoZNOYgx/9jFfHp
 pAB4X1JtMIObHbvaq7SGCoW+yZSNZg3YP9yYeaJv4tWBODMY4J+AEWTZKDwOyGcFhvAj
 +kOA==
X-Gm-Message-State: AOJu0YxTIR3NasrYN2MobyUibqoM+cKL85F1LQC3tXrGnPma9kBfPz1R
 ZLwH8loYzMXI2MzPD/mKOBEyTXDKqJgHZ4kfLVyj1ourpyLijkUO2b4+GL5NlUgGBVnHSE/fLnl
 6B+7ennjIpoWpO/wWKjFWKZE=
X-Received: by 2002:a0c:ead2:0:b0:66d:1bbb:e9f8 with SMTP id
 y18-20020a0cead2000000b0066d1bbbe9f8mr747623qvp.6.1698351312152; 
 Thu, 26 Oct 2023 13:15:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8lnnAjejV4T0eLjaQ2cML9EC3yuG2PYBbc8twuXnebev3aWloq8M0Jy/dCHpT6QcAa42dsg==
X-Received: by 2002:a0c:ead2:0:b0:66d:1bbb:e9f8 with SMTP id
 y18-20020a0cead2000000b0066d1bbbe9f8mr747611qvp.6.1698351311912; 
 Thu, 26 Oct 2023 13:15:11 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 y9-20020a0cec09000000b0066d11c1f578sm59699qvo.97.2023.10.26.13.15.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 13:15:11 -0700 (PDT)
Date: Thu, 26 Oct 2023 16:14:44 -0400
From: Peter Xu <peterx@redhat.com>
To: Joao Martins <joao.m.martins@oracle.com>
Cc: farosas@suse.de, quintela@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH 4/3] migration: Add tracepoints for downtime checkpoints
Message-ID: <ZTrItAnR74n4GaL2@x1n>
References: <20231026155337.596281-1-peterx@redhat.com>
 <20231026190159.608025-1-peterx@redhat.com>
 <46fcd5e3-db39-46a9-979f-a649a5477be8@oracle.com>
 <ZTrHNIoaWfLADBUU@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZTrHNIoaWfLADBUU@x1n>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

On Thu, Oct 26, 2023 at 04:08:20PM -0400, Peter Xu wrote:
> On Thu, Oct 26, 2023 at 08:43:59PM +0100, Joao Martins wrote:
> > Considering we aren't including any downtime timestamps in the tracing, is this
> > a way to say that the tracing tool printing timestamps is what we use to extract
> > downtime contribution?
> > 
> > It might be obvious, but perhaps should be spelled out in the commit message?
> 
> Sure, I'll state that in the commit message in a new version.

After a second thought, I'll rename it into vmstate_downtime_checkopint().

I'll wait for 1-2 more days for further review comments before a repost.

Thanks,

-- 
Peter Xu


