Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D4AB77E7B1E
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 10:59:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1OHV-0005wh-00; Fri, 10 Nov 2023 04:58:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1r1OHS-0005rW-Vw
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 04:58:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1r1OHR-0002r7-BH
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 04:58:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699610304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jNCOR/zdN7Dy1EQycEnbWxmtLnNuo/iMzLT/CBcYsa8=;
 b=EFOIlb2l3D23fQTtRcN5n4mFFO6wZ2YmAt8RwEVCLIIjLNGYUEKoMDSzWecn7lgyp3fLxv
 lNiAXdB4KdPYuKfCf3iESuBRZ1Afg9I9r4e8b3Bvf4dkGW6WCNJmS7739rCNdNkPsGyuZm
 rhRIrHTsmny+VM/XyVfc+Ecdip+y0sI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-rAn11NnVNn-AHE8M37b0bQ-1; Fri, 10 Nov 2023 04:58:22 -0500
X-MC-Unique: rAn11NnVNn-AHE8M37b0bQ-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-67012b06439so20157626d6.1
 for <qemu-devel@nongnu.org>; Fri, 10 Nov 2023 01:58:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699610302; x=1700215102;
 h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jNCOR/zdN7Dy1EQycEnbWxmtLnNuo/iMzLT/CBcYsa8=;
 b=hyLbIn0XCwVayRW+37wAUzKLgUCfSbwIc9AALO2gfmTr2H70ueKWwTXVYpBFopm86C
 wSoNvHtn/jnROnZD6t2VbFSqj5bTNeW+f5o9u3wjuw+9D7tjZydzJ1akiWfVmROubp2J
 1qKzt6zI5ZAaBpy5Q2CEp1CRZ5tHbBmvtm2N0GHzayXbgZop3sFWfwORwQijkIVPuSv4
 Ate70Wt1iFaNs/54ix9cK33+k1jbKikeebo5b6IKNMTEx2cQoBH0HziudwGnO8kXxebk
 PJxPUySd0WfDDHrmWmZRk9y+m3yB+4JgZeqsqXThGdMl5rV7p+opJVH4evdPsyxh0C08
 CtbA==
X-Gm-Message-State: AOJu0YzKPvgpK+vwXbRZA9Kkcy39A9Z3DpKCiKQhG5acrV9UZFLCCy7A
 UYrcIcrgrLiJOO5ZkG/yMNq9q4XL/raCA96ySPynXbq/mZnasBGgLQdzYU2tAh7j10n1GuI/tni
 B1HenCzEPxgLNt2dgjVO9yP76spHb9nA=
X-Received: by 2002:a05:6214:e4e:b0:674:fa5a:45b5 with SMTP id
 o14-20020a0562140e4e00b00674fa5a45b5mr8068969qvc.38.1699610301815; 
 Fri, 10 Nov 2023 01:58:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHgdeT8cEh7xvZdORojj8SsjxNiKnME2shCNgIEmOWxEDlWRTzevUQGHwrtoDJ/bKq5nMZyIIUU7/1ueEN2DbE=
X-Received: by 2002:a05:6214:e4e:b0:674:fa5a:45b5 with SMTP id
 o14-20020a0562140e4e00b00674fa5a45b5mr8068956qvc.38.1699610301592; Fri, 10
 Nov 2023 01:58:21 -0800 (PST)
Received: from 744723338238 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 10 Nov 2023 01:58:20 -0800
From: Andrea Bolognani <abologna@redhat.com>
References: <20231016152704.221611-1-victortoso@redhat.com>
 <20231016152704.221611-5-victortoso@redhat.com>
 <CABJz62NbJAkLRS7t3JN8T-=1mkZ9BX68Jgd+VPr0tYwQPZNKag@mail.gmail.com>
 <gcsvqv4zxbe2ujyexzfc2fgh5vo2vxlmgcelbcin7u2zecemox@4erxiqf7jg7y>
MIME-Version: 1.0
In-Reply-To: <gcsvqv4zxbe2ujyexzfc2fgh5vo2vxlmgcelbcin7u2zecemox@4erxiqf7jg7y>
Date: Fri, 10 Nov 2023 01:58:20 -0800
Message-ID: <CABJz62OLy=JThQLwDPXBpdrsa5kLijegk=c34isBa=ABygVK-w@mail.gmail.com>
Subject: Re: [PATCH v2 04/11] qapi: golang: Generate qapi's alternate types in
 Go
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

On Thu, Nov 09, 2023 at 08:01:48PM +0100, Victor Toso wrote:
> On Thu, Nov 09, 2023 at 09:34:56AM -0800, Andrea Bolognani wrote:
> > We should call this Null instead of IsNull, and also make it a
> > pointer similarly to what I just suggested for union branches
> > that don't have additional data attached to them.
>
> I don't have a strong argument here against what you suggest, I
> just think that the usage of bool is simpler.
>
> The test I have here [0] would have code changing to something
> like:
>
> When is null:
>
>   - val := &StrOrNull{IsNull: true}
>   + myNull := JSONNull{}
>   + val := &StrOrNull{Null: &myNull}
>
> So you need a instance to get a pointer.
>
> When is absent (no fields set), no changes as both bool defaults
> to false and pointer to nil.
>
> The code handling this would change from:
>
>   - if u.IsNull {
>   + if u.Null != nil {
>         ...
>     }
>
> We don't have the same issues as Union, under the hood we Marshal
> to/Unmarshal from "null" and that would not change.
>
> [0] https://gitlab.com/victortoso/qapi-go/-/blob/main/test/type_or_null_test.go
>
> I can change this in the next iteration.

No, leave the type alone. But I still think the name should probably
be Null instead of IsNull.

-- 
Andrea Bolognani / Red Hat / Virtualization


