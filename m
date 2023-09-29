Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 338877B318F
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 13:39:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmBpq-0008QW-39; Fri, 29 Sep 2023 07:39:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1qmBpl-0008Pp-DX
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 07:39:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1qmBpf-0002ti-TX
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 07:39:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695987533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CmV22US4bKPsS1Ytw+HMAmpIZpvXUb40b4FgFvdMWpQ=;
 b=QDrpeCQHhdzFdp4Bl2515o1rzxInFCFpR9ge+otFBFssdug9TVwzUgKdx2s+Pjl1OEmaCs
 qS8cV7I/SiAivZceC0vBho90FvjqS3/B0nZlMZqZwq/irnC8Fnqlnp45LzhwDMk9+d3Gib
 81V+FOIlWwpy7CjkmoD+cjNOfrsq8HY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-100-8BbQYIAoPeCA3r55ld3bzQ-1; Fri, 29 Sep 2023 07:38:51 -0400
X-MC-Unique: 8BbQYIAoPeCA3r55ld3bzQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 96EFA1C07547
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 11:38:51 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.95])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 568E310005D2;
 Fri, 29 Sep 2023 11:38:51 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id EB4D71800638; Fri, 29 Sep 2023 13:38:49 +0200 (CEST)
Date: Fri, 29 Sep 2023 13:38:49 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, berrange@redhat.com
Subject: Re: [PATCH] ramfb: implement migration support
Message-ID: <qqyblqt52o5gl4ufonhsadq3j52qy3c63jk3oppamoz4xn3qud@fah3e3g6xc42>
References: <20230920082651.3349712-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230920082651.3349712-1-marcandre.lureau@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Sep 20, 2023 at 12:26:51PM +0400, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Implementing RAMFB migration seems quite straightforward. Unfortunately,
> current QEMU didn't block migration when RAMFB was used.
> 
> Having an extra "ramfb" VMState doesn't seem to "break" migration
> forward compatibility. Surprisingly, missing sections are being ignored?
> 
> Backward compatiblity however will have this extra error:
> qemu: Unknown savevm section or instance 'ramfb' 0. Make sure that your current VM setup matches your saved VM setup, including any hotplugged devices.

I guess that is only fixable by making old machine types bug-compatible,
i.e. register the ramfb vmstate only for qemu 8.2+ machine types.

Otherwise looks fine to me.

take care,
  Gerd


