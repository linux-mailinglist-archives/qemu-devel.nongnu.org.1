Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FABE71F9F0
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 08:17:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4y5r-0001Ip-8B; Fri, 02 Jun 2023 02:16:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q4y5h-0001F4-CK
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 02:16:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q4y5f-0001Lf-2z
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 02:16:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685686604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sFoybfyqnyrOJPLOT1gUh+rR7nD/5E2FttFjX4+sQ7k=;
 b=TBZeqxgAF2siH5OOiQgRgvRjo8621g/JYR9zmMRyePgC7LYf8YyU4J3shDSAt4xH1hegwH
 C3IIOUr8aFW3xP594YgXmmH5gVsJg8tARi8tTLQh8JROjf01EoyhXMgUgi/84CFAVashN/
 DCWywINyNbux83qn0wrFez7jnFlZG40=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-370-otxRyx1fPRamYC_PTTwLhQ-1; Fri, 02 Jun 2023 02:16:41 -0400
X-MC-Unique: otxRyx1fPRamYC_PTTwLhQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4DE9A29AA2CB;
 Fri,  2 Jun 2023 06:16:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.170])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D9311492B00;
 Fri,  2 Jun 2023 06:16:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C018B21E692E; Fri,  2 Jun 2023 08:16:38 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org,  Hanna Czenczek <hreitz@redhat.com>,  Gerd
 Hoffmann <kraxel@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Kevin Wolf <kwolf@redhat.com>,  Peter
 Lieven <pl@kamp.de>,  Michael Roth <michael.roth@amd.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  qemu-block@nongnu.org
 (open list:GLUSTER),  integration@gluster.org (open list:GLUSTER)
Subject: Re: [PULL 09/21] cutils: Adjust signature of parse_uint[_full]
References: <20230601220305.2130121-1-eblake@redhat.com>
 <20230601220305.2130121-10-eblake@redhat.com>
Date: Fri, 02 Jun 2023 08:16:38 +0200
In-Reply-To: <20230601220305.2130121-10-eblake@redhat.com> (Eric Blake's
 message of "Thu, 1 Jun 2023 17:02:53 -0500")
Message-ID: <874jnqz8vt.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Sorry for being late to the party...

Eric Blake <eblake@redhat.com> writes:

> It's already confusing that we have two very similar functions for
> wrapping the parse of a 64-bit unsigned value, differing mainly on
> whether they permit leading '-'.  Adjust the signature of parse_uint()
> and parse_uint_full() to be like all of qemu_strto*(): put the result
> parameter last, use the same types (uint64_t and unsigned long long
> have the same width, but are not always the same type), and mark
> endptr const (this latter change only affects the rare caller of
> parse_uint).  Adjust all callers in the tree.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
> Message-Id: <20230522190441.64278-8-eblake@redhat.com>

[...]

> diff --git a/qapi/opts-visitor.c b/qapi/opts-visitor.c
> index 587f31baf6b..8812d23677a 100644
> --- a/qapi/opts-visitor.c
> +++ b/qapi/opts-visitor.c
> @@ -454,8 +454,8 @@ opts_type_uint64(Visitor *v, const char *name, uint64_t *obj, Error **errp)
>      OptsVisitor *ov = to_ov(v);
>      const QemuOpt *opt;
>      const char *str;
> -    unsigned long long val;
> -    char *endptr;
> +    uint64_t val;

val changes from unsigned long long, which is at least 64 bits, to
uint64_t, which is exactly 64 bits.

> +    const char *endptr;
>
>      if (ov->list_mode == LM_UNSIGNED_INTERVAL) {
>          *obj = ov->range_next.u;
> @@ -471,17 +471,17 @@ opts_type_uint64(Visitor *v, const char *name, uint64_t *obj, Error **errp)
>      /* we've gotten past lookup_scalar() */
>      assert(ov->list_mode == LM_NONE || ov->list_mode == LM_IN_PROGRESS);
>
> -    if (parse_uint(str, &val, &endptr, 0) == 0 && val <= UINT64_MAX) {
> +    if (parse_uint(str, &endptr, 0, &val) == 0 && val <= UINT64_MAX) {

val <= UINT64_MAX is now useless, isn't it?

>          if (*endptr == '\0') {
>              *obj = val;
>              processed(ov, name);
>              return true;
>          }
>          if (*endptr == '-' && ov->list_mode == LM_IN_PROGRESS) {
> -            unsigned long long val2;
> +            uint64_t val2;

val2 changes from unsigned long long, which is at least 64 bits, to
uint64_t, which is exactly 64 bits.

>              str = endptr + 1;
> -            if (parse_uint_full(str, &val2, 0) == 0 &&
> +            if (parse_uint_full(str, 0, &val2) == 0 &&
>                  val2 <= UINT64_MAX && val <= val2 &&

val2 <= UINT64_MAX is now useless, isn't it?

>                  val2 - val < OPTS_VISITOR_RANGE_MAX) {
>                  ov->range_next.u = val;

[...]


