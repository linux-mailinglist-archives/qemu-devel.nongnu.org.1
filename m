Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE1BAC4E1B
	for <lists+qemu-devel@lfdr.de>; Tue, 27 May 2025 14:02:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJsKO-0004Av-09; Tue, 27 May 2025 07:18:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uJsJo-0004AA-6y
 for qemu-devel@nongnu.org; Tue, 27 May 2025 07:18:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uJsJg-0007uD-IX
 for qemu-devel@nongnu.org; Tue, 27 May 2025 07:18:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748344671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YmlGt6pmIt7epH7/hMNYNn1U7uErIOmZuHFa/g6bMKs=;
 b=Topc9BVYVEEN2ufoKbMuwVs+HazLshWcjw1aR0rZ9zKxtW+93BYrDAYIFyxsB8g/ZEjnkt
 wak12RphynXX5XcG6HTBWWS5a7cqRKOogfFMJRvWY+7Om0wa/eIN2ydXyUbwxnBT6UfDOT
 rGtrm5+wT7mW15KXIeXz+8kUosMeNio=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-498-5cEGrAPOM_q-T5jK2MnGKw-1; Tue,
 27 May 2025 07:17:48 -0400
X-MC-Unique: 5cEGrAPOM_q-T5jK2MnGKw-1
X-Mimecast-MFC-AGG-ID: 5cEGrAPOM_q-T5jK2MnGKw_1748344666
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ADC72195608A; Tue, 27 May 2025 11:17:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2E6E2180049D; Tue, 27 May 2025 11:17:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8E44121E6757; Tue, 27 May 2025 13:17:43 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  michael.roth@amd.com,  thuth@redhat.com,
 pbonzini@redhat.com,  richard.henderson@linaro.org,  armbru@redhat.com,
 peter.maydell@linaro.org,  berrange@redhat.com,  philmd@linaro.org
Subject: Re: [PATCH v4 14/15] qapi/misc-i386: s/field will be set/field is set/
In-Reply-To: <20250522190542.588267-15-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Thu, 22 May 2025 12:05:41 -0700")
References: <20250522190542.588267-1-pierrick.bouvier@linaro.org>
 <20250522190542.588267-15-pierrick.bouvier@linaro.org>
Date: Tue, 27 May 2025 13:17:43 +0200
Message-ID: <87r00aqp48.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> As requested by Markus:
>> I'd prefer "field is set".
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  qapi/misc-i386.json | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/qapi/misc-i386.json b/qapi/misc-i386.json
> index 3fda7a20bdd..6f79817e382 100644
> --- a/qapi/misc-i386.json
> +++ b/qapi/misc-i386.json
> @@ -129,7 +129,7 @@
>  # Return information about SEV/SEV-ES/SEV-SNP.
>  #
>  # If unavailable due to an incompatible configuration the
> -# returned @enabled field will be set to 'false' and the
> +# returned @enabled field is set to 'false' and the
>  # state of all other fields is undefined.
>  #
>  # Returns: @SevInfo

I'd squash this into PATCH 02.  I figure you didn't because PATCH 02 is
Daniel's.  Here's how I would record provenance when squashing:

    Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
    Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
    [Doc comment tweaked]
    Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

If you want to blame me for the tweak (kidding, it's fine), you could
use [Doc comment tweaked at Markus's request].


