Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 076C07B2E58
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 10:48:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm996-0003jB-GP; Fri, 29 Sep 2023 04:46:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm993-0003hK-M0
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:46:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm991-0004bN-59
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:46:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695977200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0WKC0iKceMfwiB5uE6lV43fAo/vOqadcZd52s+0OcEU=;
 b=KIOOX+TSgXSjKraPQqKXd31foWL3+X8K8zGFgnDX0H+SK8tq0SyQd9rbBAIKK24EZHSFqB
 T611c3qq6wHAXkH9jd+eVG18R76zbYFctMDsAx7OHFh5Mu2mgjc80YWkXuFH6PkBTJ+zxa
 xo8CAq/NYZFRZp/QMkyfqYScwpDwwBk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-584-Q2eRpKk-Nleaux8Pgdod1A-1; Fri, 29 Sep 2023 04:46:38 -0400
X-MC-Unique: Q2eRpKk-Nleaux8Pgdod1A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 81D5D101A529;
 Fri, 29 Sep 2023 08:46:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5C08A492C37;
 Fri, 29 Sep 2023 08:46:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4FF5321E6904; Fri, 29 Sep 2023 10:46:37 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,  Igor Mammedov
 <imammedo@redhat.com>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,  qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/acpi: changes towards enabling -Wshadow=local
References: <20230922124203.127110-1-anisinha@redhat.com>
 <87msx5jztb.fsf@pond.sub.org>
 <5A625074-8DE2-4B58-8B7D-C7FA578F6688@redhat.com>
 <87r0mhik1n.fsf@pond.sub.org>
 <B1B5F17E-5EDB-4F4F-ABAE-2A45216FBE68@redhat.com>
 <874jjdflvg.fsf@pond.sub.org>
 <DA7D0A58-0B6B-4AFB-908A-F60EE2B7CC41@redhat.com>
Date: Fri, 29 Sep 2023 10:46:37 +0200
In-Reply-To: <DA7D0A58-0B6B-4AFB-908A-F60EE2B7CC41@redhat.com> (Ani Sinha's
 message of "Fri, 29 Sep 2023 13:38:47 +0530")
Message-ID: <87edihe58y.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

Ani Sinha <anisinha@redhat.com> writes:

> Your shadow-next has no changes. Have you not pushed to that branch?

I did, but only after I was done updating patches.  Intend to post my
pull request shortly.


