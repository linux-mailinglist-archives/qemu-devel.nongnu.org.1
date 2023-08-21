Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D103A782E8A
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 18:37:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY7tA-0007PI-3C; Mon, 21 Aug 2023 12:36:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qY7t7-0007Oe-NY
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 12:36:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qY7t5-0000hg-HE
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 12:36:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692635777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ns2h2oQBNkxnVqOUQKNPBEINcqq6c8ztOSsP6sm0BLs=;
 b=K6pEaL7ExSQFgP26nF17hoait7rjWQ+5Bx9d42OU5oT5umygki3dMpyDZT6G8cxherc0Qa
 eaAICF7EBmKW/Ij0bddXgDmrB2qgHuIdKl0CM9EVePwfOW9ZtsjJQpVLLb2r+QBzo0JpU8
 wpbBKI/Ar7G2PETvOo4M7LembBHgunI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-3OOXgdOMMUyo0RVu5oYjrg-1; Mon, 21 Aug 2023 12:36:11 -0400
X-MC-Unique: 3OOXgdOMMUyo0RVu5oYjrg-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4059b5c3dd0so9488501cf.0
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 09:36:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692635771; x=1693240571;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ns2h2oQBNkxnVqOUQKNPBEINcqq6c8ztOSsP6sm0BLs=;
 b=GmN54iB786TDprMgXGsAjfHl/8+rOtsmKwcD1nlgYx2YMQtvS3Tw5fpxG+T2MytUao
 O+5VL77WvwIXoXqRukDFWksJRVLsKuqQOUdU552msTVFStnzBEWEk6lcHaL0UvPQ9cuJ
 6oC7X+GTatzs8pqsmDsodiH6lwKjPfHIVrvBb1DPnLyxUA7tp/zsCHFECrw/Im41GJVv
 UKtnPLTY9Njai6gK+97hKDb5KXQ9p3yQgu1CMaTEnyhbR9JaG0jmteSlsf+AyV/ogG9h
 JZ2SQdlA58xoF7xjL4I4j1WmwONAGFaKrSQp3vpfbEkUcJKk/tiNtjjjSqAOdPM4fcvZ
 VZxA==
X-Gm-Message-State: AOJu0YwG2Cizzy4lugMAg3eaVGz/kWgE5HKhRaSORtCW4YZl8Mtwc87h
 q0I46cJwCdHLV6mOIOmvqof+Z+bDr2FiwpbG8uB4QhagafmpKmcBcEn7HZ5F5PgW1hN/Vuo+ycO
 mwd8o/rdLWXIiEbc=
X-Received: by 2002:a05:622a:1894:b0:403:b115:fbe with SMTP id
 v20-20020a05622a189400b00403b1150fbemr9256199qtc.1.1692635771501; 
 Mon, 21 Aug 2023 09:36:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1c565LgwfjXM7UVSftTfHMRXyJhzerH9d5xklXqS3l+xmRm0f7B+Q5KmOE5X98oe7U7cNSA==
X-Received: by 2002:a05:622a:1894:b0:403:b115:fbe with SMTP id
 v20-20020a05622a189400b00403b1150fbemr9256179qtc.1.1692635771194; 
 Mon, 21 Aug 2023 09:36:11 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 z25-20020ac86b99000000b004052f71f79bsm2416004qts.74.2023.08.21.09.36.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 09:36:10 -0700 (PDT)
Date: Mon, 21 Aug 2023 12:36:09 -0400
From: Peter Xu <peterx@redhat.com>
To: Het Gala <het.gala@nutanix.com>
Cc: qemu-devel@nongnu.org, prerna.saxena@nutanix.com, quintela@redhat.com,
 dgilbert@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 armbru@redhat.com, eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com
Subject: Re: [PATCH v10 00/10] migration: Modify 'migrate' and
 'migrate-incoming' QAPI commands for migration
Message-ID: <ZOOSecV/AcAwbgzl@x1n>
References: <20230726141833.50252-1-het.gala@nutanix.com>
 <30cffa41-3e39-205f-5119-d84d6303f58c@nutanix.com>
 <a81add8b-f08b-6589-e9f5-779a4a7bd63f@nutanix.com>
 <3fb6b8c1-7790-3ad6-62b1-81642e878f7d@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3fb6b8c1-7790-3ad6-62b1-81642e878f7d@nutanix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

Het,

On Mon, Aug 21, 2023 at 11:43:02AM +0530, Het Gala wrote:
> Hi qemu-devel community,
> 
> A gentle reminder and request for all migration maintainers - Peter, Juan,
> Dr. Gilbert and others too for review of the patchset series. Received
> reviewed-by from Daniel on migration implementation patches but need final
> approval from migration maintainers before getting it merged. Also got
> acked-by tag from Markus on the QAPI patches. This is Part1 of the 4
> patchset series. Ultimate goal of the whole 4 series is to 'introduce
> multiple interface support on top of existing multifd capability'. Hope to
> get approval or comments from migration maintainers on the patches soon.

This all looks right to me from high level.  I'd just trust Daniel's in
depth review already, considering that Juan will probably give a final
round of look soon, anyway.

Juan was just busy in the past few weeks; I suppose he'll catch up very
soon.

Thanks,

-- 
Peter Xu


