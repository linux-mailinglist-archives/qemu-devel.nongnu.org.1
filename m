Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5829D7B853D
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 18:28:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo4j5-0003vO-CZ; Wed, 04 Oct 2023 12:27:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo4j2-0003kr-89
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 12:27:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo4j0-0006m9-NF
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 12:27:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696436869;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=vA6XU5r1TTSJsTW6Uj6SvZyIbQvMgSKeglT24Evfqxc=;
 b=gnmJuEV7DQp4Anj+pxRaFRA0wEGnP8UaySGmswaKTL+oRm1Jw7nGyEWPr/fxQmtJO9ziKj
 WBZRonypclNAHvXWR33goFJ9VVxs9/PQdGQHsdE3P5it4p2wTbzui5c/O//WjYJRHA4x7q
 yF1DwRl0+Obzn13A8/9ifbJHiamArtE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-N2bTdTAxOnuCSZkaAqTpjw-1; Wed, 04 Oct 2023 12:27:48 -0400
X-MC-Unique: N2bTdTAxOnuCSZkaAqTpjw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3231fceb811so35364f8f.2
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 09:27:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696436867; x=1697041667;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vA6XU5r1TTSJsTW6Uj6SvZyIbQvMgSKeglT24Evfqxc=;
 b=UB158eSAWRlJJQcn2nT/fbWjL/cpgvMNpAWce7hJ0DrExXmFZm/WK0wvuJol1yuMps
 CSXqwAuVumw6J68/69r1sm3dX1BgljgvmEILVxJRf97OMCYlMH8YtiPs0HTp3Bx9jGfU
 BiJdeY4K1mn6elIGMApY3S2oDjlahr2GSvcLz6JB22wVyitWE2/2+h5Xt9Wxem73IjHP
 NbaL5WMH027JRGZSUAAuDXEMg/vubY3TCSf7hE0rDMIl0CSq3VC/LQxkVGXa8PKAiKBp
 JcaQ85/2NmxJR8Abq6k4XK7R1NtMKQ+7fRZ1u/qheD7Rpi4AQ+abQoK47+wZHVN3J3W7
 HDCQ==
X-Gm-Message-State: AOJu0YyNNokbSgeBQRkDhIBfyFYH+NuECqdElp8wjOHkS/GXMjiKRZm+
 img+t3hwvoRFSCOlj1+cVnok3Y08NpebvFeL17sih8uNSwtHnbunh/P/UjcPUJX4xJCqfN7t/TN
 Oo3Wru2nKhSgB1EA=
X-Received: by 2002:adf:f845:0:b0:317:df82:2868 with SMTP id
 d5-20020adff845000000b00317df822868mr2550487wrq.26.1696436867598; 
 Wed, 04 Oct 2023 09:27:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAw5gPNDCx0BGP2/6XYnoDPiFFlHhwM9Zs/zK4KpJw4SDYMDq105gFMDr9KVEMk1FbCl3uxA==
X-Received: by 2002:adf:f845:0:b0:317:df82:2868 with SMTP id
 d5-20020adff845000000b00317df822868mr2550472wrq.26.1696436867352; 
 Wed, 04 Oct 2023 09:27:47 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 j14-20020a5d464e000000b0031f8a59dbeasm4330166wrs.62.2023.10.04.09.27.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 09:27:46 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  leobras@redhat.com,
 farosas@suse.de,  lizhijian@fujitsu.com,  eblake@redhat.com
Subject: Re: [PATCH v2 30/53] migration/rdma: Plug a memory leak and improve
 a message
In-Reply-To: <20230928132019.2544702-31-armbru@redhat.com> (Markus
 Armbruster's message of "Thu, 28 Sep 2023 15:19:56 +0200")
References: <20230928132019.2544702-1-armbru@redhat.com>
 <20230928132019.2544702-31-armbru@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 04 Oct 2023 18:27:46 +0200
Message-ID: <87o7heuzct.fsf@secure.mitica>
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
> When migration capability @rdma-pin-all is true, but the server cannot
> honor it, qemu_rdma_connect() calls macro ERROR(), then returns
> success.
>
> ERROR() sets an error.  Since qemu_rdma_connect() returns success, its
> caller rdma_start_outgoing_migration() duly assumes @errp is still
> clear.  The Error object leaks.
>
> ERROR() additionally reports the situation to the user as an error:
>
>     RDMA ERROR: Server cannot support pinning all memory. Will register memory dynamically.
>
> Is this an error or not?  It actually isn't; we disable @rdma-pin-all
> and carry on.  "Correcting" the user's configuration decisions that
> way feels problematic, but that's a topic for another day.
>
> Replace ERROR() by warn_report().  This plugs the memory leak, and
> emits a clearer message to the user.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


