Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A01778269E
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 11:56:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY1cg-0002sP-HG; Mon, 21 Aug 2023 05:54:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <twiederh@redhat.com>)
 id 1qY1ce-0002sB-Oy
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 05:54:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <twiederh@redhat.com>)
 id 1qY1cc-0001ZV-CC
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 05:54:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692611692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SKTv0OBMPR8nig6i500VPvoGDm9Ac4tMsO+XuYTQKkw=;
 b=H8lveWsfqPgxYNmQegmr1tj/vwWRsnVu29o7KwaRX8ytvPRaG5+1nVm/aYpLJuWLvN9Kh4
 ueWolH68UyQ6NDF3z3SfVAFwBKf+K3Sh9jVTBsAvYB36t7Pl809w5whhlu50Hpun17TpGg
 Y9KBwTU8VLts6Hm05wQoD3c4FB2+pVo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-__3ySnNnOvaPUiYUyRw97g-1; Mon, 21 Aug 2023 05:54:49 -0400
X-MC-Unique: __3ySnNnOvaPUiYUyRw97g-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3113da8b778so1870729f8f.3
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 02:54:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692611689; x=1693216489;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SKTv0OBMPR8nig6i500VPvoGDm9Ac4tMsO+XuYTQKkw=;
 b=N7QXgxmrplz/CKJA0CM78K3+WJiIY6FvmUh1uO3COpVWbsu4nNILKpM1ZbNPe4zzUn
 Wpf8DBp7dN67CXU3QbXbxXmzEpszSYm6tL6bDIanLyxk7Nc0kZ9nndeDlgHkRTmpBvxI
 ED7UKaR4BM/mTe4/SuB36CAr/IkCSpeLmYLeiy1uBwDhLRivky4kfWA9DUKuW4pWjNDp
 rcLCDfskHSkb2mPgOoJYTqa/Ir+1TWI0WT6hcwLoI79wbtgMh1Y3wGbwEopEBwPod2xH
 YXtUNOGjfHJxzmKb6tn0dBeGzLdO3dIM5M028Zfi+ueyUkTuweZORFThXM++z09p1ITZ
 EIqw==
X-Gm-Message-State: AOJu0YzuVzMc3c6J240Ysf1ZWMkbYRrRWmegCaGgY7/v6BrBtET8zSwG
 D0xnG+rrUP57yAsgkat/A1kP2VI2rod5yKgBk6WE/+9EdMOsZh+QSWVAbhLfq54iwdX/AnCprZc
 drVcUW+lMElElKlY=
X-Received: by 2002:adf:f291:0:b0:318:c108:67b0 with SMTP id
 k17-20020adff291000000b00318c10867b0mr4412361wro.48.1692611688764; 
 Mon, 21 Aug 2023 02:54:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhEGC/UAfL8dZ5gxGwhiKhK9fg1dqpB9s3l14q3cEkuNb8mT/IMVvuZ36d2wtxgJg2Vd8+CQ==
X-Received: by 2002:adf:f291:0:b0:318:c108:67b0 with SMTP id
 k17-20020adff291000000b00318c10867b0mr4412353wro.48.1692611688467; 
 Mon, 21 Aug 2023 02:54:48 -0700 (PDT)
Received: from [192.168.178.136] (port-92-192-116-175.dynamic.as20676.net.
 [92.192.116.175]) by smtp.gmail.com with ESMTPSA id
 o2-20020adfcf02000000b00317a04131c5sm11814710wrj.57.2023.08.21.02.54.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 02:54:47 -0700 (PDT)
Message-ID: <37b9e75a96188b6e2693ae6b2128e7a31b76bb82.camel@redhat.com>
Subject: Re: [PATCH 2/4] target/i386: Translate feature_word_info to xml
From: Tim Wiederhake <twiederh@redhat.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Date: Mon, 21 Aug 2023 11:54:47 +0200
In-Reply-To: <ZN3/fUEyC7sSqWy7@redhat.com>
References: <20230811135011.23343-1-twiederh@redhat.com>
 <20230811135011.23343-3-twiederh@redhat.com> <ZN3/fUEyC7sSqWy7@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
Received-SPF: pass client-ip=170.10.129.124; envelope-from=twiederh@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Thu, 2023-08-17 at 12:07 +0100, Daniel P. Berrang=C3=A9 wrote:
> On Fri, Aug 11, 2023 at 03:50:09PM +0200, Tim Wiederhake wrote:
> > This is the data file that will be used to generate the C code.
> > All information, including the comments, is preserved.
> >=20
> > Signed-off-by: Tim Wiederhake <twiederh@redhat.com>
> > ---
> > =C2=A0target/i386/feature_word_info.xml | 1607
> > +++++++++++++++++++++++++++++
> > =C2=A01 file changed, 1607 insertions(+)
> > =C2=A0create mode 100644 target/i386/feature_word_info.xml
> >=20
> > diff --git a/target/i386/feature_word_info.xml
> > b/target/i386/feature_word_info.xml
> > new file mode 100644
> > index 0000000000..ff741b9f5a
> > --- /dev/null
> > +++ b/target/i386/feature_word_info.xml
> > @@ -0,0 +1,1607 @@
> > +<feature_words>
>=20
> I think adding data formats based on XML is pretty undesirable
> for QEMU. AFAIK, the only place we've used XML is where we
> needed to have interoperability with an external tool.
>=20
> Can we not just do this using JSON instead, which would avoid
> the need to write python parsing code as we can directly load
> it into a python object.
>=20
> With regards,
> Daniel

I thought of json as well, but that has some drawbacks over xml here:

Integer values, e.g. "eax=3D0x80000008", would need to be stored in
either decimal form or as a string. Both solutions are not desirable in
my opinion.

Additionally, preserving the comments is not as straight forward.
Comments in json are a non-standard extension and not understood by all
parsers, e.g. python's json module. This would require some regex-
preprocessing that comes with its own problems.

Regards,
Tim


