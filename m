Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D21A7D8985
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 22:10:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qw6fA-0004YR-KQ; Thu, 26 Oct 2023 16:09:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qw6es-0004Cn-4G
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 16:08:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qw6em-0008UG-Oq
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 16:08:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698350919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kL/4n+bE8WtexmWpfvsA08BSGkJZax59rBa8Kyrlr9I=;
 b=Z6ceGmtgMCcI5ZbwpV3GMcfodofEakG9eS0KAWpgS+J/T3JhlF2Y7IzxV7N4vvPYlfhVrG
 4clQ4lxnA6JQN4f2yPr//QnEu506SAcB/4TMi5TRVv32iRGVsk0r1UCmd6BeEEBW1pPJ06
 2gU4Uhigm2a4rqH2z4reaH7phTnYDYA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-jthH3uX6NIiNP7BYuXSDSg-1; Thu, 26 Oct 2023 16:08:22 -0400
X-MC-Unique: jthH3uX6NIiNP7BYuXSDSg-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-637948b24bdso3966596d6.1
 for <qemu-devel@nongnu.org>; Thu, 26 Oct 2023 13:08:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698350902; x=1698955702;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kL/4n+bE8WtexmWpfvsA08BSGkJZax59rBa8Kyrlr9I=;
 b=meJ2RDJTifJXkA3zVXkx4d09r0VP9P0odgsV31b7Rgkw7rOsf83bu3v1C94hyoz2Oe
 7g9usUNVxkk9pUObdXKq4jgj8eNSfLyavXr6eFyIdZcrilMXKH5awQY58EVAYPFIWAer
 dP3OVvWZfbHo53JRJii4og3TLMF9lHBAmvSihu+4qAKrO+p9Boz6OsXWX/3W6bm4AQrx
 2Aml22ydibRyVYKiZAz4AW5zWf4AJLE8zwfilricWqnkAuQ26yqEVTTbraICnnJAGz8z
 eNAGIkRT7+tAdmvW2jF+pVcGUHgpEzggr6Xxp77+HVY8UvS70JXsUlhnYxG/0mGUTkUH
 n0xQ==
X-Gm-Message-State: AOJu0YzRcHizPS5vuIAHDSr1icitoFOQfvaKAl2kUkuMIGPYtnPfXZWj
 6CJjTSyZrS5iiDDiRAwdIIhMrgmsgHpRLeqWaBi3iqUCJCPJhgnSnrZT7b7R9pbYq7mIWs2ev5M
 BMDQ/+UVB/sE+1pk=
X-Received: by 2002:ad4:4d51:0:b0:66d:b23:a62e with SMTP id
 m17-20020ad44d51000000b0066d0b23a62emr703648qvm.6.1698350902350; 
 Thu, 26 Oct 2023 13:08:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwj65rkiNV2w/KldaH7jXwb3MBoZLi+5SbmEKRU1qe8CU+C42bWZ+JwmdYlRdP2aZ6jIWfBQ==
X-Received: by 2002:ad4:4d51:0:b0:66d:b23:a62e with SMTP id
 m17-20020ad44d51000000b0066d0b23a62emr703630qvm.6.1698350902107; 
 Thu, 26 Oct 2023 13:08:22 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 c16-20020a0cd610000000b0065d89f4d537sm61921qvj.45.2023.10.26.13.08.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 13:08:21 -0700 (PDT)
Date: Thu, 26 Oct 2023 16:08:20 -0400
From: Peter Xu <peterx@redhat.com>
To: Joao Martins <joao.m.martins@oracle.com>
Cc: farosas@suse.de, quintela@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH 4/3] migration: Add tracepoints for downtime checkpoints
Message-ID: <ZTrHNIoaWfLADBUU@x1n>
References: <20231026155337.596281-1-peterx@redhat.com>
 <20231026190159.608025-1-peterx@redhat.com>
 <46fcd5e3-db39-46a9-979f-a649a5477be8@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <46fcd5e3-db39-46a9-979f-a649a5477be8@oracle.com>
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

On Thu, Oct 26, 2023 at 08:43:59PM +0100, Joao Martins wrote:
> Considering we aren't including any downtime timestamps in the tracing, is this
> a way to say that the tracing tool printing timestamps is what we use to extract
> downtime contribution?
> 
> It might be obvious, but perhaps should be spelled out in the commit message?

Sure, I'll state that in the commit message in a new version.

-- 
Peter Xu


