Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDF87B827F
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 16:37:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo2zO-0006uz-3H; Wed, 04 Oct 2023 10:36:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo2z5-0006uU-Px
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 10:36:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo2z2-0004M1-Dq
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 10:36:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696430175;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=57mWlJdCWUciOLkqVcM9S3zgRNQ/31AeSsFO3pMPFuY=;
 b=ZzAEgHA/GM3v628tXVrfCNBRqsaPvyxKhiftoM9Qz2dXwIOeJZSpEkPPFnuRKAaoRvAcCm
 2SIMOXvJOcytcaUQXDK7Qy3O19KThfjQFYVDScY6PE7RookfSX8w8nNuDuXfcaDvuxNhhX
 EDoCxHqbv3yRMHLyru4EFKdVhk5bX60=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-xhfAhxc6OuOduKKHH7hw3Q-1; Wed, 04 Oct 2023 10:35:59 -0400
X-MC-Unique: xhfAhxc6OuOduKKHH7hw3Q-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-32172e3679bso1674453f8f.2
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 07:35:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696430158; x=1697034958;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=57mWlJdCWUciOLkqVcM9S3zgRNQ/31AeSsFO3pMPFuY=;
 b=fSiMsgq2jFv28TD42ADp0nDPNpnKYmw80ltLh+cHCgBKmEwl+wtl+LI1LEZ52dHy0y
 91975gf59DtbDX+QbnC5E7zssU+jQ8D3vF58aa4qtSbtuoLhYSZes4OU7zC+yrfplyU/
 YguWkrsrByocq7icUQUDUDfA/fZXZKDFBmSFSjboineCxpl+MprqKZjSaPEabLg5iNo5
 27z4FTGnFx9fA358CosJaw2ZuskVrDSQ9za9jGdBR+AU0mF1qNbtgk3+q5He4Lqv4QeU
 pgfJmPLqNJtTKSvtA/Fb7YsJbHDSskJZxyQ2i6NogYJs+vb/419EVuoCldQOTnUiaeTc
 X4eg==
X-Gm-Message-State: AOJu0YxJc38KUTcwOVb9Cqh2tMENUSvuZmN00GEoiLwvlxYzJIGSCoJ0
 uFNMy0Z2QE2PvJn0+3611yqmyzyRCJMCeNg1WIMZgDFl0TVew2/bo5T8L3qc/KzXFAtj04UpA7M
 QHkw+NLAGs1jMGjQ=
X-Received: by 2002:a05:6000:128a:b0:31a:d9bc:47a2 with SMTP id
 f10-20020a056000128a00b0031ad9bc47a2mr2684754wrx.53.1696430157857; 
 Wed, 04 Oct 2023 07:35:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAr/5g8FKoNUsHvu5nIlkvpJOziOxa15djtSGNvb5w/Wir6Gz1KVUX7eeEbKLr/Wb1N2ubxg==
X-Received: by 2002:a05:6000:128a:b0:31a:d9bc:47a2 with SMTP id
 f10-20020a056000128a00b0031ad9bc47a2mr2684741wrx.53.1696430157568; 
 Wed, 04 Oct 2023 07:35:57 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 g14-20020a056000118e00b003231ca246b6sm4158150wrx.95.2023.10.04.07.35.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 07:35:56 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  leobras@redhat.com,
 farosas@suse.de,  lizhijian@fujitsu.com,  eblake@redhat.com
Subject: Re: [PATCH v2 02/53] migration/rdma: Clean up
 qemu_rdma_data_init()'s return type
In-Reply-To: <20230928132019.2544702-3-armbru@redhat.com> (Markus Armbruster's
 message of "Thu, 28 Sep 2023 15:19:28 +0200")
References: <20230928132019.2544702-1-armbru@redhat.com>
 <20230928132019.2544702-3-armbru@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 04 Oct 2023 16:35:56 +0200
Message-ID: <8734yq1mlv.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Markus Armbruster <armbru@redhat.com> wrote:
> qemu_rdma_data_init() return type is void *.  It actually returns
> RDMAContext *, and all its callers assign the value to an
> RDMAContext *.  Unclean.
>
> Return RDMAContext * instead.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

queued


