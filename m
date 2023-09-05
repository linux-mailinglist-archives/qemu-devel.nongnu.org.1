Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4FB79206C
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 08:01:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdP73-0007P7-A3; Tue, 05 Sep 2023 02:00:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qdP6y-0007LX-N5
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 02:00:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qdP6w-0003SX-Ch
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 02:00:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693893615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Uj/FUF9kdH1u7/Y1YRXG7KQQcWdDWEQOwu6iBdGaBYQ=;
 b=aD2CoHT+99szZByRb3HIeVzaacbI/NcD4gjONvvC/+kc3DN3FxV/PK6e0QeaIwMFzdeP/q
 hGvVTz4fDssGPrDjeBzYDN71s2phmo/rzBFpC3US1jEeBUpN5BUKTdpDuM7LIDpQQ4eD+H
 6RCQBbLFnTTToamJEU2OYBLdF2EHUSc=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-86ClV2jyMSuAvhWwVUb97Q-1; Tue, 05 Sep 2023 02:00:13 -0400
X-MC-Unique: 86ClV2jyMSuAvhWwVUb97Q-1
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-7a7770e5cd0so585109241.1
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 23:00:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693893613; x=1694498413;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Uj/FUF9kdH1u7/Y1YRXG7KQQcWdDWEQOwu6iBdGaBYQ=;
 b=A8l7oo3ZdEN/jmPTCVHn88+tXOv2JpzWJOSMPL2FJDW4gcVW2rk5Ox6oUVEB1VC3IX
 IHhPB7OLcJFnY+UFcpnI9fmI0btueyJhVDw+SaArwmCncdzmB4FYF5RAOwm1u3wrVZyI
 O4dbE//6s6wh3TW1yIkzVYv4hwkLK46nySlZEz6q3KmKFmqa+zOPOJAU4NFd3EVkdctd
 lB1fui3jibteashJwcJFO3Ndf3jSt5JmDftRrIB9HW2LV+ZlRkL+Z2X7lVmhDBjW0KAl
 BOVT2hwotxT3xLljXo8mzPkUfn1tpbO97dILECVuIFObxSDa7ERfVlOGYlUr6rpeUzuj
 Qndw==
X-Gm-Message-State: AOJu0Yx/Q0vpJsqLjjoFuCU7HViXXH9YU2FWCig0YCy5GhHPUPbfDKyQ
 3yx+7Pbcj/X8nm7VDf5szm9zZNP5N6EqKH+Bl0J+S/0puIlYxUS+Cp+d+wTAMhY3wgnqc9rtKIr
 RSZf9YGqOcYD7GW/9RkmXG42L1PKgN64=
X-Received: by 2002:a05:6102:3bd1:b0:44d:4aa1:9d3f with SMTP id
 a17-20020a0561023bd100b0044d4aa19d3fmr9904140vsv.4.1693893612966; 
 Mon, 04 Sep 2023 23:00:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGoTTNTfwQIFTth/Hg+6Flr3YV8gfTb2Tkm45ZTem9HxiN2h+/ugcWGu0sENxyfmE8gvgRlyFXZHQczUYJUxWo=
X-Received: by 2002:a05:6102:3bd1:b0:44d:4aa1:9d3f with SMTP id
 a17-20020a0561023bd100b0044d4aa19d3fmr9904133vsv.4.1693893612699; Mon, 04 Sep
 2023 23:00:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230902125934.113017-1-pbonzini@redhat.com>
 <20230902125934.113017-7-pbonzini@redhat.com>
 <14a94f46-1f15-1480-c0dc-613a21004186@redhat.com>
In-Reply-To: <14a94f46-1f15-1480-c0dc-613a21004186@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 5 Sep 2023 08:00:00 +0200
Message-ID: <CABgObfaD2zc7kv1dqt82_vuDZesP_-PSSUU_Nm-bCQ2+m6puVQ@mail.gmail.com>
Subject: Re: [PATCH 06/15] configure: remove boolean variables for targets
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="00000000000012995c060496571f"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--00000000000012995c060496571f
Content-Type: text/plain; charset="UTF-8"

Il lun 4 set 2023, 10:15 Thomas Huth <thuth@redhat.com> ha scritto:

> It might look nicer to put the linux and solaris parts from above as
> separate entries in the new case-esac statement.
>

True but it all disappears by the end of the series.

Paolo


> Anyway:
> Reviewed-by: Thomas Huth <thuth@redhat.com>
>
>

--00000000000012995c060496571f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il lun 4 set 2023, 10:15 Thomas Huth &lt;<a href=3D"ma=
ilto:thuth@redhat.com">thuth@redhat.com</a>&gt; ha scritto:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex">It might look nicer to put the linux and solaris p=
arts from above as <br>
separate entries in the new case-esac statement.<br></blockquote></div></di=
v><div dir=3D"auto"><br></div><div dir=3D"auto">True but it all disappears =
by the end of the series.</div><div dir=3D"auto"><br></div><div dir=3D"auto=
">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gm=
ail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex">
<br>
Anyway:<br>
Reviewed-by: Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com" target=3D"=
_blank" rel=3D"noreferrer">thuth@redhat.com</a>&gt;<br>
<br>
</blockquote></div></div></div>

--00000000000012995c060496571f--


