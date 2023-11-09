Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F19A7E7160
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 19:25:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r19hc-0000Pv-4G; Thu, 09 Nov 2023 13:24:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1r19ha-0000Mf-B4
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 13:24:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1r19hY-0006Mp-Lq
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 13:24:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699554263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fLqE0Tbe8gSccKvA754i+fR+AcekGdi9big6RF/MC3M=;
 b=F7HdHBJJyknoPE+mcY0NhE/yR8YwhV1Kxlww6zmMrgCb0nBMUkaDW5WE/uVMD9HTnELVgq
 oOv5QMAabLCKRvhGKQ0L9JNKojI03kD0ob8+7xgmoexYksqmswX+LCGOD7nFc+gsygYYyC
 RyTWQW0UoVXut2oQMi3CN8mx/hX0RSo=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-fBSmcCV9OoKMYhVysS_o6A-1; Thu, 09 Nov 2023 13:24:22 -0500
X-MC-Unique: fBSmcCV9OoKMYhVysS_o6A-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-41e58a33efaso14609281cf.2
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 10:24:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699554261; x=1700159061;
 h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fLqE0Tbe8gSccKvA754i+fR+AcekGdi9big6RF/MC3M=;
 b=iscgg237ALFtabzppGFt5Fgqt2pZ1RxC0rtnCBIcj6Al+K4FqMIBPpGE+wdq3QzicJ
 L3Eb+ojlMGZz7keaIUbCxRL5TEILQ0GmKRou79ROJduroJSgu6Pb2pJ7L3RjaUhnsP6z
 5wRhfYP55EVKtOose/g4x7phqg49B9w7FnpBzEsEdpRtr56GPh2Pmnhy6Hbmd0ZGS8H0
 0pWYGT+XCf6STDWj4LTvcl6jeOXPvtLY2rcBSBtX84Aie8/aP0gCHPU/U9oVK/rHaCJc
 FgejsEkEfdcuy4uGY3MDawK5OlBMoiumVKglIOPBhjJmhiut7JTHiV94SjHivlAHmwpw
 CC1g==
X-Gm-Message-State: AOJu0Ywt8hdoTCFi/IyFn93uN9ORbRNRrAo8JxD+e+BwBWI3pSnYohN5
 r4ulwsGUI7TST8+N63kWipE6qSniKMywwYA0vloBk/PIQhUgEJGLVVyQfizGrzxtxG1GmaQkhY9
 Bc9F1kBlvd3CWW+HchyYEgv3ry467aAQ=
X-Received: by 2002:a05:622a:487:b0:418:d18:56ae with SMTP id
 p7-20020a05622a048700b004180d1856aemr7117567qtx.25.1699554261503; 
 Thu, 09 Nov 2023 10:24:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHUqWjk+v4+PuMqMEg63UXDtRTzgRknbBLkQoWbn11zudSLpFGI4/cdujB7Z3gTeJQMR23liM2KMx1zEu7B3nM=
X-Received: by 2002:a05:622a:487:b0:418:d18:56ae with SMTP id
 p7-20020a05622a048700b004180d1856aemr7117550qtx.25.1699554261222; Thu, 09 Nov
 2023 10:24:21 -0800 (PST)
Received: from 744723338238 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 9 Nov 2023 10:24:20 -0800
From: Andrea Bolognani <abologna@redhat.com>
References: <20231016152704.221611-1-victortoso@redhat.com>
 <20231016152704.221611-11-victortoso@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20231016152704.221611-11-victortoso@redhat.com>
Date: Thu, 9 Nov 2023 10:24:20 -0800
Message-ID: <CABJz62PJVbhJkqCzsSHfHSbeZ8PX74OGjbhf6uKZy7JBxnoa5Q@mail.gmail.com>
Subject: Re: [PATCH v2 10/11] qapi: golang: Add CommandResult type to Go
To: Victor Toso <victortoso@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=abologna@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

On Mon, Oct 16, 2023 at 05:27:03PM +0200, Victor Toso wrote:
> This patch adds a struct type in Go that will handle return values
> for QAPI's command types.
>
> The return value of a Command is, encouraged to be, QAPI's complex
> types or an Array of those.
>
> Every Command has a underlying CommandResult. The EmptyCommandReturn
> is for those that don't expect any data e.g: `{ "return": {} }`.
>
> All CommandReturn types implement the CommandResult interface.

I guess EmptyCommandReturn is something that you have scrapped in
between revisions, because I see no reference to it in the current
incarnation of the code. Same thing with CommandResult, unless that's
just a typo for CommandReturn?

> Example:
> qapi:
>     | { 'command': 'query-sev', 'returns': 'SevInfo',
>     |   'if': 'TARGET_I386' }
>
> go:
>     | type QuerySevCommandReturn struct {
>     |     MessageId string     `json:"id,omitempty"`
>     |     Result    *SevInfo   `json:"return"`
>     |     Error     *QapiError `json:"error,omitempty"`
>     | }
>
> usage:
>     | // One can use QuerySevCommandReturn directly or
>     | // command's interface GetReturnType() instead.

I'm not convinced this function is particularly useful. I know that
I've suggested something similar for events, but the usage scenarios
are different.

For events, you're going to have some loop listening for them and you
can't know in advance what event you're going to receive at any given
time.

In contrast, a return value will be received as a direct consequence
of running a command, and since the caller knows what command it
called it's fair to assume that it also knows its return type.

> +        if ret_type:
> +            marshal_empty = ""
> +            ret_type_name = qapi_schema_type_to_go_type(ret_type.name)
> +            isptr = "*" if ret_type_name[0] not in "*[" else ""
> +            retargs.append(
> +                {
> +                    "name": "Result",
> +                    "type": f"{isptr}{ret_type_name}",
> +                    "tag": """`json:"return"`""",
> +                }
> +            )

This produces

  type QueryAudiodevsCommandReturn struct {
    MessageId string     `json:"id,omitempty"`
    Error     *QAPIError `json:"error,omitempty"`
    Result    []Audiodev `json:"return"`
  }

when the return type is an array. Is that the correct behavior? I
haven't thought too hard about it, but it seems odd so I though I'd
bring it up.

-- 
Andrea Bolognani / Red Hat / Virtualization


