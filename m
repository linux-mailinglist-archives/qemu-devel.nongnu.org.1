Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 06AA3827ABF
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 23:45:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMyLy-00053C-Gb; Mon, 08 Jan 2024 17:44:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rMyLx-000534-FV
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 17:44:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rMyLv-0005a1-A7
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 17:44:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704753853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lOR3sf/zcnF9NbI4NHxCyjjn/CJP92G4URkYqDnrJxY=;
 b=ajPGVbe/bzEVKdch8IUCkYF0Ow9j6ZLlYiADxdgs7tMUfTqs7oREaQ2g8g95UZwVrCuRvH
 WSgnduKMdrw2Z5gRHbBNOxoyhJa966Z+wpfMrOugm3oF3evFrxKPjWu5/4p9Y189REaETG
 zz5jQh+NAjdy+kUNnXni/4dnshn9IRE=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-m38E-iDwPnO3cYGA6SMnPw-1; Mon, 08 Jan 2024 17:44:11 -0500
X-MC-Unique: m38E-iDwPnO3cYGA6SMnPw-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-28d1df091ecso1039516a91.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 14:44:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704753850; x=1705358650;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lOR3sf/zcnF9NbI4NHxCyjjn/CJP92G4URkYqDnrJxY=;
 b=rzQh2BiiTAhZFzqIExSIVV6IOVH6dL84dpsXggXqheAWltWQehO+OPGiIxUtvG+UtF
 QY4D0dRX0jxmHQgp0lOnQYkjAws23tSNDeohmDHtxTcSRspyJv3dIJb4bdNzF5Yi6ilR
 COFyp9Kv597aXWTWB4tZ5Ps0BvgADZbtXzcSYFuaulfzvJ4ZGjaMkMauR1QmIKKc3tJb
 0OCOQAAIte8SjiaWwTbNqoiEvbr3RQREuEpkoCcEQbr4h0jAOaAxfg+LreUqZDIxFEBI
 s+JixWyrQiHd8Qw+ZwkUTZ1z1HiQWdZsVARzlopyVU7k18nVG9xAjaA7j6aSJAO8A8PV
 0mJw==
X-Gm-Message-State: AOJu0YznNJ2mVHqszsjFlFvgkIoEkViATUfJdxn83uISV3BKKnhZap/O
 XEgTv9FBE7grypq4Ahz7pzFEOaLUzlW38j/0SvnQzc2rxcmxqSxlj9vJyVV8+B/8Cc/kINMidI9
 aa/W6cu9OFsynJFP+uWy5E+sz+yQ60Rei/rpr5Es=
X-Received: by 2002:a17:90a:d998:b0:28b:bc2a:6cc0 with SMTP id
 d24-20020a17090ad99800b0028bbc2a6cc0mr1688023pjv.26.1704753850735; 
 Mon, 08 Jan 2024 14:44:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGcbr7iq4mW3iu7yxqb97aD9SzJofXN8Q3Rij20Ed6nv8dyJTNq3Yft8OO48uzfo4CHY8UrfiZIVpr8sTnzPJA=
X-Received: by 2002:a17:90a:d998:b0:28b:bc2a:6cc0 with SMTP id
 d24-20020a17090ad99800b0028bbc2a6cc0mr1688000pjv.26.1704753850379; Mon, 08
 Jan 2024 14:44:10 -0800 (PST)
MIME-Version: 1.0
References: <20231214155333.35643-1-davydov-max@yandex-team.ru>
 <874jgah03l.fsf@pond.sub.org>
In-Reply-To: <874jgah03l.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Mon, 8 Jan 2024 17:43:59 -0500
Message-ID: <CAFn=p-Yk3usVMa4S1MVKUzpebHgAeKCn9anRi7-0C83sa-kNnQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/4] compare machine type compat_props
To: Markus Armbruster <armbru@redhat.com>
Cc: Maksim Davydov <davydov-max@yandex-team.ru>, qemu-devel@nongnu.org,
 eduardo@habkost.net, 
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com, 
 crosa@redhat.com, bleal@redhat.com, eblake@redhat.com, pbonzini@redhat.com, 
 berrange@redhat.com, alxndr@bu.edu, bsd@redhat.com, stefanha@redhat.com, 
 thuth@redhat.com, darren.kenny@oracle.com, Qiuhao.Li@outlook.com, 
 lvivier@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.243,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, Dec 22, 2023 at 7:51=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Something odd is going on here.
>
> Your cover letter and PATCH 4 arrived here with
>
>     Content-Type: text/plain; charset=3DUTF-8
>
> Good.
>
> PATCH 2:
>
>     Content-Type: text/plain; charset=3D"US-ASCII"; x-default=3Dtrue
>
> PATCH 1 and 3:
>
>     Content-Type: text/plain; charset=3DN
>
> git-am chokes on that:
>
>     error: cannot convert from N to UTF-8
>

Patchew also complains that it hasn't received the full series:

https://patchew.org/QEMU/20231214155333.35643-1-davydov-max@yandex-team.ru/

Please consider rebasing and resending?

--js


