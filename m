Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F973AE5BBA
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Jun 2025 07:03:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTvnm-0005A4-Js; Tue, 24 Jun 2025 01:02:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uTvnk-00057K-34
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 01:02:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uTvni-0006M9-Go
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 01:02:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750741348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=731w+p3Ou+TZkq+14QblW9/mFJD/jtYIfZ9G9oFtbYc=;
 b=T9Rq3RKEDvN9+DeoctkZj+xm4mVTgVGDxMN4/zd+3UlKrAQroT2u4BBZaToSGq7RWlSILS
 jfemGkejrmGPyWdm28W+HkwQAp0pzO3tIkqgPQrt5+CkLRVHGKrZvYE+Q22LzSrTlN0sdN
 +7xCL/ylMnK1kLCUvh9CVLG8WFsnBUY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-232-TiyF1iG9OwucG8uLx-fdgA-1; Tue,
 24 Jun 2025 01:02:24 -0400
X-MC-Unique: TiyF1iG9OwucG8uLx-fdgA-1
X-Mimecast-MFC-AGG-ID: TiyF1iG9OwucG8uLx-fdgA_1750741343
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ACACA180034E; Tue, 24 Jun 2025 05:02:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.10])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F297C1956096; Tue, 24 Jun 2025 05:02:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4336A21E6A27; Tue, 24 Jun 2025 07:02:19 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>,  qemu-devel@nongnu.org,  Daniel P
 . =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Thomas Huth
 <thuth@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,  Gerd Hoffmann
 <kraxel@redhat.com>,  Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Kevin Wolf
 <kwolf@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>,  Alexander
 Graf <agraf@csgraf.de>,  Paolo Bonzini <pbonzini@redhat.com>,  Richard
 Henderson <richard.henderson@linaro.org>,  Peter Maydell
 <peter.maydell@linaro.org>
Subject: Re: [PATCH v5 0/3] docs: define policy forbidding use of "AI" / LLM
 code generators
In-Reply-To: <87h60614eo.fsf@draig.linaro.org> ("Alex =?utf-8?Q?Benn=C3=A9?=
 =?utf-8?Q?e=22's?= message of "Mon, 23 Jun 2025 23:25:51 +0100")
References: <20250616092241.212898-1-armbru@redhat.com>
 <CAJSP0QV=mfmUt7s+iBkJtZsLiNd1v2c6tNrZeG8htBs58JHhrA@mail.gmail.com>
 <87h60614eo.fsf@draig.linaro.org>
Date: Tue, 24 Jun 2025 07:02:19 +0200
Message-ID: <871pr93f6s.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Stefan Hajnoczi <stefanha@gmail.com> writes:
>
>> Any final comments before I merge this?
>
> It's well reviewed lets get it merged.

Stefan, would you like a PR from me?


