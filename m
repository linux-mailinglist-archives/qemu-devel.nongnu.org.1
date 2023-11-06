Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 510847E297F
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 17:13:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r02Dk-0000E3-O3; Mon, 06 Nov 2023 11:13:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1r02Di-00005W-2W
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 11:12:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1r02Dd-0003c5-SZ
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 11:12:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699287172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Jgl4T7B+8J7r8Bxki0Mu/a5d/tmsLTiKScjHEttnYXE=;
 b=JOm1MF5Lu4qNnCMrI3wrAR9xXpA1MsD5vJNClqvIXdOjERINBt76/i+OmKHfM+bltF+gvc
 6OiI9x+n2Go7PXCcQ8a36wfV7g/QmLjcECJnih2P29mXNvIgm06ePd3b/BDfKElrmpKN80
 9bB3KhEhaMSrgtmBp8rMbPYe6NHtGRU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-3jnuXwtFNsOLTGSYjQ7yVg-1; Mon, 06 Nov 2023 11:12:42 -0500
X-MC-Unique: 3jnuXwtFNsOLTGSYjQ7yVg-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-41cc9224395so50965491cf.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 08:12:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699287160; x=1699891960;
 h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Jgl4T7B+8J7r8Bxki0Mu/a5d/tmsLTiKScjHEttnYXE=;
 b=sqxNRZw96RKKqA2h5Ahfu9alcto4QKFImBEw3/xLqY+xAEnxatztfXhkweWd8NyySd
 TtOEmdcxHbr4QHILJ+ZgBtxHpIuHTuY4vbxINqBhwfFJvc01Zqe+TTexL/J13E6G6N6+
 EjJDxTavghk2Bc8OVaG1KOhXzWkY8uyvsfejhi7oIzhTnjsCsxmDiEL1sraRS73xCFUv
 67ufLu3l0npz3VU4so5WzNT1kSjQuMkUwVAIPBnuaCbjPrCEcudzbKy38OGQ7fehVg8Y
 XCu3ykT1S1N/D87gMPWn71ZO/8+iEa16EwkR+V7wUHSG0xTdBc68KuJIfzKy3rxPpvv7
 uu0A==
X-Gm-Message-State: AOJu0YxTVVjPhZ1R/9+c0QcBnsEi7BSl59XxgCxy8BLPhSFy79t5PacA
 d5OLxR6ikOhxKlRu6GwloqNkUSZYhmAA1Eg1oRV7PKlTpwzVjsEdwm9FTR8EZ5agUCltIBACY0o
 TxxPTgk+D2MTzZjPez04hUcyvb7bVbGarZzZxOnQ=
X-Received: by 2002:a05:622a:1004:b0:403:a8fa:b4f5 with SMTP id
 d4-20020a05622a100400b00403a8fab4f5mr36361377qte.4.1699287160312; 
 Mon, 06 Nov 2023 08:12:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH39NekZqBm2IPq+vJ3xaaUDz9ARErRczhMvM5um9czsGHH8/iYkrtFNEN2G3svtb8Hy/43hul5Gy1zu50aHuY=
X-Received: by 2002:a05:622a:1004:b0:403:a8fa:b4f5 with SMTP id
 d4-20020a05622a100400b00403a8fab4f5mr36361357qte.4.1699287160065; Mon, 06 Nov
 2023 08:12:40 -0800 (PST)
Received: from 744723338238 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 6 Nov 2023 08:12:38 -0800
From: Andrea Bolognani <abologna@redhat.com>
References: <20231016152704.221611-1-victortoso@redhat.com>
 <20231016152704.221611-5-victortoso@redhat.com>
 <CABJz62O9YKuRHqW2_WUijzY5PfqmjxDjbU=7-O4cp0OO+JQi3g@mail.gmail.com>
 <hlu7dit5w6oxjz6ib423ak3ptzppdvuvltymzinxb3v2o2mwwa@xyfns7sv77gj>
MIME-Version: 1.0
In-Reply-To: <hlu7dit5w6oxjz6ib423ak3ptzppdvuvltymzinxb3v2o2mwwa@xyfns7sv77gj>
Date: Mon, 6 Nov 2023 08:12:38 -0800
Message-ID: <CABJz62Pnixs87S-8ot3bST523_BXs50SinEri_w71EkPExr8Nw@mail.gmail.com>
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

On Mon, Nov 06, 2023 at 04:52:12PM +0100, Victor Toso wrote:
> On Mon, Nov 06, 2023 at 07:28:04AM -0800, Andrea Bolognani wrote:
> > On a partially related note: while I haven't yet looked closely at
> > how much effort you've dedicated to producing pretty output, from a
> > quick look at generate_struct_type() it seems that the answer is "not
> > zero". I think it would be fine to simplify things there and produce
> > ugly output, under the assumption that gofmt will be called on the
> > generated code immediately afterwards. The C generator doesn't have
> > this luxury, but we should take advantage of it.
>
> Yes, I wholeheartedly agree. The idea of the generator producing
> a well formatted Go code came from previous review. I didn't want
> to introduce gofmt and friends to QEMU build system, perhaps it
> wasn't a big deal but I find it foreign to QEMU for a generated
> code that QEMU itself would not use.
>
> See: https://lists.gnu.org/archive/html/qemu-devel/2023-10/msg01188.html

Noted.

Whether or not requiring a pass through gofmt is an issue kind of
depends on how we end up shipping these files.

What seems the most probable to me is that we'll have a separate repo
where we dump the generated files and that Go users will consume via
a regular 'import'. Your existing qapi-go repo follows this model. In
this context, gofmt is never going to be called as part of the QEMU
build process so it doesn't really matter.

But maybe there was a discussion around this that I've missed :)

-- 
Andrea Bolognani / Red Hat / Virtualization


