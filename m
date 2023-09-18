Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6727A4C93
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 17:36:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiGHl-0005Vc-Ld; Mon, 18 Sep 2023 11:35:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qiGHj-0005VJ-Br
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 11:35:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qiGHh-0006OO-Uq
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 11:35:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695051336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WSRDxsjxE4tcXi59aTyditc/juAJE8z5BFDuygqHd3A=;
 b=Xyo5xhxT6eVE12LQ9a7MObTqkVTTRyUypfMRLWOTy/mEVxbqoXOd7VRWfVhTSgc54H81i9
 nFPcYaGnqeBoXTXFmtOc4HjZINVmDnbghTDPyHinJcRtf9P5zW4bb2laSQmK15hvOl3pnb
 7/Nmf0NnUql09uYVodidKK+RconCpg4=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-CM2XeQ6GPXqNIiwAS-K2cg-1; Mon, 18 Sep 2023 11:35:34 -0400
X-MC-Unique: CM2XeQ6GPXqNIiwAS-K2cg-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-414e9f38bc9so11855611cf.1
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 08:35:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695051334; x=1695656134;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WSRDxsjxE4tcXi59aTyditc/juAJE8z5BFDuygqHd3A=;
 b=jRGr/vm9fedNgJBUuk6F0m6AMpKNjxaPvsyM1akQJCTlUSIc2Jbah2VBCcnnPpRWyb
 q0/41WDd9zjIPGnwxduMJN84HSPr7QhdwaKvA7O0cEbbcLi+Id31iLb9E5UGZPOu9IJ0
 Ej9cYYcr7G32R/SbBzf2K1IwnNdHM1OD4EPnyy7eW+kN2B8vzCkJw9pK1csFL8TnHJaR
 bBZH3RfAH4VRUnKniPXEsR9MKk7O8w9pSF1vVGVNFJNkuuPeNi2Ij4z1hkR2pmIxsh3T
 ioBH5WUwXVNMnM48WBg5k9fCZDUpTecOoaYls3hKHFp6RTEyW+qrL9lRGiK2017DgbF1
 piLw==
X-Gm-Message-State: AOJu0YwGvRHLoD3Xp0r/uLdpwvSyzYDKFfSRwdgheWX9DGrWOuSfkNki
 UrxmPIiDMgi8uB1kEIjLADktxl/QBeJICsQ5WTpZe2xCYSpKu8b1QalNsVmxdsneXu+hsZTuH+O
 jehXvtUNkSxleumQ=
X-Received: by 2002:a05:622a:1a1f:b0:417:944a:bcd0 with SMTP id
 f31-20020a05622a1a1f00b00417944abcd0mr9932872qtb.3.1695051334416; 
 Mon, 18 Sep 2023 08:35:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5SYXaN8jAqkIgXRWZXrH41gy+W2EfUe73omsJ/9JccD2C4Z5KL3Qn1ROM47U6YFX3XHLDhw==
X-Received: by 2002:a05:622a:1a1f:b0:417:944a:bcd0 with SMTP id
 f31-20020a05622a1a1f00b00417944abcd0mr9932859qtb.3.1695051334184; 
 Mon, 18 Sep 2023 08:35:34 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 m3-20020ac84443000000b00415184b1151sm3085616qtn.51.2023.09.18.08.35.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Sep 2023 08:35:33 -0700 (PDT)
Date: Mon, 18 Sep 2023 11:35:31 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, qemu-devel@nongnu.org
Subject: Re: QEMU migration-test CI intermittent failure
Message-ID: <ZQhuQ4cJzSigZ2ll@x1n>
References: <ZQMoUzRH1BZKs39g@x1n> <87bke4kasr.fsf@suse.de>
 <ZQM3SV4eqSltoQSe@x1n> <87led8e9vv.fsf@suse.de>
 <87r0n0nz6u.fsf@suse.de> <ZQOW4BS1ZcDTN7tK@x1n>
 <87o7i4nqrc.fsf@suse.de> <ZQSGNDn2gg5if8ie@x1n>
 <ZQSMekgtg5kIPl2H@x1n> <878r931s9u.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <878r931s9u.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Sep 18, 2023 at 11:15:57AM -0300, Fabiano Rosas wrote:
> This fixes the issue. It looks ok to me. Do you want me to send a separate patch with it?

I've consulted Stefan on how to proceed.  I think it's wanted that we have
these fixes in first even before Juan's back (note: Juan will be further
away for quite some days, unfortunately..).

Fabiano, would you propose a patchset containing your patches 1-8 and also
the patch I attached that you tested (please make sure the fixup is
squashed into the same patch), so that Stefan can merge directly before
Juan's back?  Please mention in the cover letter that it fixes all known
(two..) migration-test possible failures for CI so Stefan will be super
clear on what that patchset is.

Thank you!

-- 
Peter Xu


