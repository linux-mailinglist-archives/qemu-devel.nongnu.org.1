Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCABBB423D
	for <lists+qemu-devel@lfdr.de>; Thu, 02 Oct 2025 16:08:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4JwD-0006c7-Hz; Thu, 02 Oct 2025 10:05:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1v4Jw5-0006bW-Ak
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 10:05:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1v4Jvu-0005y3-HJ
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 10:05:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759413908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rgHNIlpoln1HdW8BZhYh7xHB55OF4+p6kG7+fGWTIxA=;
 b=bqve2Otm6+sKMumylzHMSBm0gv8sez4/ojIK+ZQcFN8pdIH++3nvOSOvuFawa+8z8HuFss
 YcYuWB5LG67pK18Z0wN9Wl8fOaEk5V6l+xVQteZPTQ5/LsntG1YgtNIivFvjHP5t+KCegl
 Sh/Ip1w3uQP+Q41w9GL56XR3mgZOBJw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-331-f-295d-DMsOK_1gBTI_zLg-1; Thu,
 02 Oct 2025 10:05:07 -0400
X-MC-Unique: f-295d-DMsOK_1gBTI_zLg-1
X-Mimecast-MFC-AGG-ID: f-295d-DMsOK_1gBTI_zLg_1759413906
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2D26C180028E; Thu,  2 Oct 2025 14:05:06 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.182])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8B24E19560B8; Thu,  2 Oct 2025 14:05:04 +0000 (UTC)
Date: Thu, 2 Oct 2025 16:05:01 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-block@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 1/3] tests/qemu-iotests/184: Fix skip message for
 qemu-img without throttle
Message-ID: <aN6GjaSvTdWkpL_j@redhat.com>
References: <20250910153727.226217-1-thuth@redhat.com>
 <20250910153727.226217-2-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910153727.226217-2-thuth@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.451,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 10.09.2025 um 17:37 hat Thomas Huth geschrieben:
> From: Thomas Huth <thuth@redhat.com>
> 
> If qemu-img does not support throttling, test 184 currently skips
> with the message:
> 
>   not suitable for this image format: raw
> 
> But that's wrong, it's not about the image format, it's about the
> throttling not being available in qemu-img. Thus fix this by using
> _notrun with a proper message instead.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Kevin Wolf <kwolf@redhat.com>


