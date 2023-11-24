Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E8E7F707D
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 10:50:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6SoR-0001r8-RK; Fri, 24 Nov 2023 04:49:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r6SoO-0001qu-LI
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 04:49:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r6SoN-0005jJ-8M
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 04:49:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700819360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pq/MaNJYVFw8uFIAPeMG0EDvs3zFTzNakl+aMmTGj/g=;
 b=XXqgWUju+YEhuTC6dYBFHibUKldtUtwsmUnO77KuruV3dPMhbKQ2yYNmVEOKepn8BWljYm
 9oRmCGP1M5RkcC7ddbgkr+5AepsKF2z5EpKIjAEKufIiqKyDlXqwkMkRPUwlLW3TgsrJro
 N9tAecf+QtyUp3pGdQNKC0uVRUcfeRE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-60-l_4V35mgOUucLwNt-qdrNg-1; Fri,
 24 Nov 2023 04:49:17 -0500
X-MC-Unique: l_4V35mgOUucLwNt-qdrNg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BFE363C0C115;
 Fri, 24 Nov 2023 09:49:15 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C9E975028;
 Fri, 24 Nov 2023 09:49:13 +0000 (UTC)
Date: Fri, 24 Nov 2023 10:49:12 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Phil =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 1/2] docs: introduce dedicated page about code provenance
 / sign-off
Message-ID: <ZWBxmJMAaqk-9Lef@redhat.com>
References: <20231123114026.3589272-1-berrange@redhat.com>
 <20231123114026.3589272-2-berrange@redhat.com>
 <20231123091654-mutt-send-email-mst@kernel.org>
 <ZV-I_eWYsBeOe4Sp@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZV-I_eWYsBeOe4Sp@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.058,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Am 23.11.2023 um 18:16 hat Daniel P. Berrangé geschrieben:
> > Suggested-by is also common.
> > 
> > As long as we are here, let's document Fixes: and Cc: ?
> 
> The submitting-a-patch doc covers more general commit message information.
> I think this doc just ought to focus on tags that identify humans involved
> in the process.
> 
> I've never been sure what the point of the 'Cc' tag is, when you actually
> want to use the Cc email header ? 

By default, git-send-email automatically copies the addresses mentioned
with Cc: in the commit message, so I always assumed that this is what
people intend with these tags.

Of course, in practice many of us have suppresscc = "all" in their
config to avoid downstream accidents, so maybe there is another use?

The only time I use it is for "Cc: qemu-stable@nongnu.org". I'm not sure
if it still works like this, but people used to look for this in the
commit history when preparing stable releases. (It's useful because
sometimes people forget to actually CC the qemu-stable list when sending
the patches.)

Kevin


