Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BAC57E7B17
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 10:48:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1O6B-0008Cs-QB; Fri, 10 Nov 2023 04:46:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1r1O69-0008CR-5A
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 04:46:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1r1O66-0008Oo-QZ
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 04:46:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699609601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YGr9teKpDewR088GgqpRw+wfjJN370YpDVWq0z0zbGA=;
 b=dSArB9obUnHqPtWhzNQRnh9B0DE0tHypRA0TiLqBurNRHgq56/3fSOJdl2HNH9DbfHsa1E
 yQ9zdqzLXqOmgzsqL8Ug4km+9LxdNcXfLLteEniPA09TtRQnMA+dc4Z1gYDB8WXmywiTb2
 tPhY6JA4xDwvpZaHKIt3sCvygJqEvJY=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-G2mHnwekN4qT571fL67ASw-1; Fri, 10 Nov 2023 04:46:40 -0500
X-MC-Unique: G2mHnwekN4qT571fL67ASw-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-66fbd3bc8ebso22356566d6.1
 for <qemu-devel@nongnu.org>; Fri, 10 Nov 2023 01:46:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699609599; x=1700214399;
 h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YGr9teKpDewR088GgqpRw+wfjJN370YpDVWq0z0zbGA=;
 b=utgxO+spofJjGH6sHhv+YV+7ReSYcBqxszrO+wqGP9mKKQVvAo3wEdnuosd27jOFlo
 4cKhfL7ncr4xWpvpwwdFzhPoUqPnNCvNVMlUrkGh3uGJL2Nw5c8+H7rAcvN1T9zDId5C
 P+QCs1mRUfczoZVxlj2kSmP3OYagRy+l4t4TmMeUOb1mzchs5vQDsspacdXEBzWvxke+
 JGJwc6Lc0kus6nbE11VqAVt4sLggTga1GhtvyIMRg/SFOGaV20WfKVwr1uRsGrF0vW6G
 kzO1kQKcsAcjISJE5MlCto1EvBAsVF8e9zXcvzzHd0j1t84pneFfNgGcKpIlhrpy/LpF
 qMsg==
X-Gm-Message-State: AOJu0YykZiRB+cf9D0rs4Q4WA/lu5qYEl8oULRkVovt6qS5whufA6kO1
 /JqHga9sqYQTvk12+59l//iV+iXr/d/ryog34ikb34y6MxgTbzpnhYiUrIEkA7hyIzHtsRXqfRx
 4G4E+kz0ub5xfSPHdlSy+ylm948kSwPk=
X-Received: by 2002:ac8:5a8b:0:b0:41c:dd22:e7bf with SMTP id
 c11-20020ac85a8b000000b0041cdd22e7bfmr7988174qtc.42.1699609599052; 
 Fri, 10 Nov 2023 01:46:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHF5rsYfCdIFxlCM5fY9JnmgxG3JTyumdNpKQQLPzZTrp29PEsws2jn/E5lijQEReozeSRGsOqipPDSgp3Rz5Q=
X-Received: by 2002:ac8:5a8b:0:b0:41c:dd22:e7bf with SMTP id
 c11-20020ac85a8b000000b0041cdd22e7bfmr7988163qtc.42.1699609598825; Fri, 10
 Nov 2023 01:46:38 -0800 (PST)
Received: from 744723338238 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 10 Nov 2023 01:46:37 -0800
From: Andrea Bolognani <abologna@redhat.com>
References: <20231016152704.221611-1-victortoso@redhat.com>
 <20231016152704.221611-11-victortoso@redhat.com>
 <CABJz62PJVbhJkqCzsSHfHSbeZ8PX74OGjbhf6uKZy7JBxnoa5Q@mail.gmail.com>
 <dfwqu6vgvmhezaorvm6vhj2kwuibpke4fvcocttrnyi2rypjat@jpwugcjwewbs>
MIME-Version: 1.0
In-Reply-To: <dfwqu6vgvmhezaorvm6vhj2kwuibpke4fvcocttrnyi2rypjat@jpwugcjwewbs>
Date: Fri, 10 Nov 2023 01:46:37 -0800
Message-ID: <CABJz62O9d_NjQ-ZYWa9=1=N4VaNbT6PhPS9EM=gRqOP=LR1R5g@mail.gmail.com>
Subject: Re: [PATCH v2 10/11] qapi: golang: Add CommandResult type to Go
To: Victor Toso <victortoso@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=abologna@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Thu, Nov 09, 2023 at 08:31:01PM +0100, Victor Toso wrote:
> On Thu, Nov 09, 2023 at 10:24:20AM -0800, Andrea Bolognani wrote:
> > On Mon, Oct 16, 2023 at 05:27:03PM +0200, Victor Toso wrote:
> > > Example:
> > > qapi:
> > >     | { 'command': 'query-sev', 'returns': 'SevInfo',
> > >     |   'if': 'TARGET_I386' }
> > >
> > > go:
> > >     | type QuerySevCommandReturn struct {
> > >     |     MessageId string     `json:"id,omitempty"`
> > >     |     Result    *SevInfo   `json:"return"`
> > >     |     Error     *QapiError `json:"error,omitempty"`
> > >     | }
> > >
> > > usage:
> > >     | // One can use QuerySevCommandReturn directly or
> > >     | // command's interface GetReturnType() instead.
> >
> > I'm not convinced this function is particularly useful. I know
> > that I've suggested something similar for events, but the usage
> > scenarios are different.
>
> I think that I wanted to expose knowledge we had in the parser,
> not necessarily useful or needed indeed. At the very least, I
> agree that at this layer, we just want Command and ComandReturn
> types to be generated and properly (un)mashalled.
>
> One downside is for testing.
>
> If we have a list of commands, I can just iterate over them
> Unmarshal to a command interface variable, fetch the return type
> and do some comparisons to see if all is what we expected. See:
>
> https://gitlab.com/victortoso/qapi-go/-/blob/main/test/examples_test.go#L61
>
> Not saying we should keep it for tests, but it is useful :)

That code is quite dense and I'm not going to dig into it now :)

Anyway, I don't have a problem with keeping this type-safe
introspection feature around. Maybe call it GetCommandReturnType
though.

> > This produces
> >
> >   type QueryAudiodevsCommandReturn struct {
> >     MessageId string     `json:"id,omitempty"`
> >     Error     *QAPIError `json:"error,omitempty"`
> >     Result    []Audiodev `json:"return"`
> >   }
> >
> > when the return type is an array. Is that the correct behavior? I
> > haven't thought too hard about it, but it seems odd so I though I'd
> > bring it up.
>
> Hm, the schema for it is
>
>   ##
>   # @query-audiodevs:
>   #
>   # Returns information about audiodev configuration
>   #
>   # Returns: array of @Audiodev
>   #
>   # Since: 8.0
>   ##
>   { 'command': 'query-audiodevs',
>     'returns': ['Audiodev'] }
>
> So, I think it is correct. Would you expect it to be an object
> wrapping the array or I'm missing what you find odd.

It works as expected if there is a result, but in the case of error:

  in := `{ "error": {"class": "errorClass", "desc": "errorDesc" }}`

  out := qapi.QueryAudiodevsCommandReturn{}
  err := json.Unmarshal([]byte(in), &out)
  if err != nil {
      panic(err)
  }
  fmt.Printf("result=%v error=%v\n", out.Result, out.Error)

the output will be

  result=[] error=errorDesc

Note how result is an empty array instead of a nil pointer. If we
unmarshal the same JSON into QueryReplayCommandReturn instead, the
output becomes

  result=<nil> error=errorDesc

The latter behavior seems more correct to me, based on how we deal
with unions and alternates.

-- 
Andrea Bolognani / Red Hat / Virtualization


