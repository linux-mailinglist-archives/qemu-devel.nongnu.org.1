Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB467BBC3F
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 17:59:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qonDj-0004KD-31; Fri, 06 Oct 2023 11:58:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qonDg-0004JR-2z
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 11:58:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qonDe-0007k6-Qd
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 11:58:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696607905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+5jvUVcbA8jNzaHzhAGJ1Tkic7d8OM5kpFEyFwLkhBI=;
 b=i9h6otB6oSTQf8PUvvwV6OTOtbHqtqhAxuZWgUheOvgbBHubKP013SUiu10Q5PQxW/e8ar
 VfSb9wCLiyuDvjqC01R7LX059C39M48nBanv30/fvaAi+M7GOzg8She3uv/9ATgWsNEepf
 3Oe1uDUbr/OaIHFsWsz+h0349ztyOOI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-459-ZmudGxPGMLK4HxdGB8rx1Q-1; Fri, 06 Oct 2023 11:58:17 -0400
X-MC-Unique: ZmudGxPGMLK4HxdGB8rx1Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 39B071C11727;
 Fri,  6 Oct 2023 15:58:17 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.151])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 71386170EE;
 Fri,  6 Oct 2023 15:58:16 +0000 (UTC)
Date: Fri, 6 Oct 2023 17:58:15 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, qemu-block@nongnu.org
Subject: Re: [PATCH v3 0/4] block: clean up coroutine versions of
 bdrv_{is_allocated,block_status}*
Message-ID: <ZSAul7SKNN3InA0Q@redhat.com>
References: <20230904100306.156197-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230904100306.156197-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 04.09.2023 um 12:03 hat Paolo Bonzini geschrieben:
> Provide coroutine versions of bdrv_is_allocated* and bdrv_block_status*,
> since the underlying BlockDriver API is coroutine-based, and use
> automatically-generated wrappers for the "mixed" versions.
> 
> v2->v3: cleaned up formatting

Thanks, applied to the block branch.

Kevin


