Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9A9830D73
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 20:49:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQBtR-0004Jh-PU; Wed, 17 Jan 2024 14:48:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rQBtK-0004JK-15
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 14:48:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rQBtI-0005cT-1p
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 14:48:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705520878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 resent-to:resent-from:resent-message-id:in-reply-to:in-reply-to:
 references:references; bh=5D1670npY2V+R2n6CwrAED/nVrNrXgHnf+CzyLmDy6Q=;
 b=F/sc1TZoorFkGXdbm6jYYDPvg/0P6CYkVRFcFhNhkVkid7Q2URCplF9NU4xGOsxGLVG5jp
 p/CmlKKN5tQJeklEwT4+7hUk+IaeY5Ao0xRgIMhni9qMps0OGP+03aEAPLklMBPebKFqq6
 5fBtnOcV11hXNNOXm02TNSRIqp0naq4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-s8rDjFKYMDmPIGiju0xAyw-1; Wed, 17 Jan 2024 14:47:55 -0500
X-MC-Unique: s8rDjFKYMDmPIGiju0xAyw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5CDEC85A588;
 Wed, 17 Jan 2024 19:47:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.128])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1D6192166B35;
 Wed, 17 Jan 2024 19:47:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id ABE8621E6806; Wed, 17 Jan 2024 20:47:49 +0100 (CET)
Resent-To: imbrenda@linux.ibm.com, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Wed, 17 Jan 2024 20:47:49 +0100
Resent-Message-ID: <87plxzg2sa.fsf@pond.sub.org>
From: Markus Armbruster <armbru@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Markus
 Armbruster <armbru@redhat.com>,  qemu-trivial@nongnu.org,  Daniel P .
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Claudio Imbrenda
 <imbrenda@linux.ibm.com>
Subject: Re: [PATCH 1/5] qemu-options: Remove the deprecated -no-hpet option
In-Reply-To: <20240112100059.965041-2-thuth@redhat.com> (Thomas Huth's message
 of "Fri, 12 Jan 2024 11:00:55 +0100")
References: <20240112100059.965041-1-thuth@redhat.com>
 <20240112100059.965041-2-thuth@redhat.com>
Date: Wed, 17 Jan 2024 13:37:42 +0100
Message-ID: <87frywjfu1.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
Lines: 8
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
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

Thomas Huth <thuth@redhat.com> writes:

> It's been marked as deprecated since QEMU 8.0, so it should be fine
> to remove this now.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>


