Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 294EC7F30B6
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 15:29:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5RjX-0001Z2-30; Tue, 21 Nov 2023 09:28:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r5RjV-0001XR-9a
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 09:28:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r5RjQ-0004TV-7D
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 09:28:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700576882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gdDhS97xJNDB8gdu1U0n9DlplUZyl7YXKFUFIhqaO1o=;
 b=dERmqHx6Q5MPa3QxBHSEQNoaULkthmYJHtsUUcEhpE68f51INcYCf8Er+46vhuDK73YBbb
 rMjwkTD6eCyQxPYtQFExVOV7/Dh5ieZyL1M15q0QSC7r2wblcRmzZRn4E5CawCE3w6z9RW
 siQnkXlG5yrGgPD08Eej097oY8mnRb8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-189-Ap2VmaxUNHyEgwl5D3WjKg-1; Tue,
 21 Nov 2023 09:28:00 -0500
X-MC-Unique: Ap2VmaxUNHyEgwl5D3WjKg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 324771C060C8;
 Tue, 21 Nov 2023 14:28:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 106AC36E4;
 Tue, 21 Nov 2023 14:28:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 07BAB21E6A1F; Tue, 21 Nov 2023 15:27:59 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH 10/19] qapi/schema: make
 QAPISchemaArrayType.element_type non-Optional
References: <20231116014350.653792-1-jsnow@redhat.com>
 <20231116014350.653792-11-jsnow@redhat.com>
Date: Tue, 21 Nov 2023 15:27:59 +0100
In-Reply-To: <20231116014350.653792-11-jsnow@redhat.com> (John Snow's message
 of "Wed, 15 Nov 2023 20:43:41 -0500")
Message-ID: <87fs0z2nbk.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

> This field should always be present and defined. Change this to be a
> runtime @property that can emit an error if it's called prior to
> check().
>
> This helps simplify typing by avoiding the need to interrogate the value
> for None at multiple callsites.
>
> RFC: Yes, this is a slightly different technique than the one I used for
> QAPISchemaObjectTypeMember.type;

In PATCH 04.

>                                  I think I prefer this one as being a
> little less hokey, but it is more SLOC. Dealer's choice for which style
> wins out -- now you have an example of both.

Thanks for letting us see both.

I believe all the extra lines accomplish is a different exception
RuntimeError with a custom message vs. plain AttributeError.

I don't think the more elaborate exception is worth the extra code.

> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  scripts/qapi/schema.py | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> index c9a194103e1..462acb2bb61 100644
> --- a/scripts/qapi/schema.py
> +++ b/scripts/qapi/schema.py
> @@ -366,7 +366,16 @@ def __init__(self, name, info, element_type):
>          super().__init__(name, info, None)
>          assert isinstance(element_type, str)
>          self._element_type_name = element_type
> -        self.element_type = None
> +        self._element_type: Optional[QAPISchemaType] = None
> +
> +    @property
> +    def element_type(self) -> QAPISchemaType:
> +        if self._element_type is None:
> +            raise RuntimeError(
> +                "QAPISchemaArray has no element_type until "
> +                "after check() has been run."
> +            )
> +        return self._element_type
>  
>      def need_has_if_optional(self):
>          # When FOO is an array, we still need has_FOO to distinguish
> @@ -375,7 +384,7 @@ def need_has_if_optional(self):
>  
>      def check(self, schema):
>          super().check(schema)
> -        self.element_type = schema.resolve_type(
> +        self._element_type = schema.resolve_type(
>              self._element_type_name, self.info,
>              self.info and self.info.defn_meta)
>          assert not isinstance(self.element_type, QAPISchemaArrayType)


