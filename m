Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 958CD7F60DD
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 14:53:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6A7U-0007hp-Iy; Thu, 23 Nov 2023 08:51:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r6A7R-0007hF-V2
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 08:51:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r6A7Q-0000bE-Dq
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 08:51:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700747507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MBcj+azawqfNdQ7ftlXl5SLHkgGgp1J7Ex/iayjCukg=;
 b=dMapzy2uibnG6mEC/ReUlk8/7It9Ua5KYgnJQG8EYsJcTbNq00qK8V+wXRVRZ/kGErfNaO
 vezfOa++A7734SzIidpY8quuBHoR/jponK/ZOr3IZC4jGkUEVAVCBvd08M3TsfvvybZMjL
 gkoO13zqRwOb7zM2LGEV74jowiqeGrE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-Rhf2IDcRODuDiIiBhRHAdQ-1; Thu,
 23 Nov 2023 08:51:45 -0500
X-MC-Unique: Rhf2IDcRODuDiIiBhRHAdQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 20CEC1C0BA48;
 Thu, 23 Nov 2023 13:51:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EB15DC1596F;
 Thu, 23 Nov 2023 13:51:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AF85721E6A1F; Thu, 23 Nov 2023 14:51:43 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH 14/19] qapi/schema: assert QAPISchemaVariants are
 QAPISchemaObjectType
References: <20231116014350.653792-1-jsnow@redhat.com>
 <20231116014350.653792-15-jsnow@redhat.com>
Date: Thu, 23 Nov 2023 14:51:43 +0100
In-Reply-To: <20231116014350.653792-15-jsnow@redhat.com> (John Snow's message
 of "Wed, 15 Nov 2023 20:43:45 -0500")
Message-ID: <87a5r44lxs.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.058,
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

John Snow <jsnow@redhat.com> writes:

> I'm actually not too sure about this one, it seems to hold up at runtime
> but instead of lying and coming up with an elaborate ruse as a commit
> message I'm just going to admit I just cribbed my own notes from the
> last time I typed schema.py and I no longer remember why or if this is
> correct.
>
> Cool!
>
> With more seriousness, variants are only guaranteed to house a
> QAPISchemaType as per the definition of QAPISchemaObjectTypeMember but
> the only classes/types that have a check_clash method are descendents of
> QAPISchemaMember and the QAPISchemaVariants class itself.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  scripts/qapi/schema.py | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> index 476b19aed61..ce5b01b3182 100644
> --- a/scripts/qapi/schema.py
> +++ b/scripts/qapi/schema.py
> @@ -717,6 +717,7 @@ def check_clash(self, info, seen):
>          for v in self.variants:
>              # Reset seen map for each variant, since qapi names from one
>              # branch do not affect another branch
> +            assert isinstance(v.type, QAPISchemaObjectType)  # I think, anyway?
>              v.type.check_clash(info, dict(seen))

Have a look at .check() right above:

       def check(
           self, schema: QAPISchema, seen: Dict[str, QAPISchemaMember]
       ) -> None:
           [...]
           if not self.variants:
               raise QAPISemError(self.info, "union has no branches")
           for v in self.variants:
               v.check(schema)
               # Union names must match enum values; alternate names are
               # checked separately. Use 'seen' to tell the two apart.
               if seen:
                   if v.name not in self.tag_member.type.member_names():
                       raise QAPISemError(
                           self.info,
                           "branch '%s' is not a value of %s"
                           % (v.name, self.tag_member.type.describe()))
--->               if not isinstance(v.type, QAPISchemaObjectType):
--->                   raise QAPISemError(
                           self.info,
                           "%s cannot use %s"
                           % (v.describe(self.info), v.type.describe()))
                   v.type.check(schema)

Since .check() runs before .check_clash(), your assertion holds.

Clearer now?


