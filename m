Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 778C57091FF
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 10:49:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzvnN-0007Al-Tm; Fri, 19 May 2023 04:49:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cconte@redhat.com>) id 1pzvnL-0007Ad-Ki
 for qemu-devel@nongnu.org; Fri, 19 May 2023 04:49:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cconte@redhat.com>) id 1pzvnK-00074J-6N
 for qemu-devel@nongnu.org; Fri, 19 May 2023 04:49:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684486140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4+lcZOAextRYht0uTCFYzj0UAcbfD5Q2qncxrtjV9oM=;
 b=SgEkVoj4dr3NQzxUf3mSiT3Xq5UGVw9prUnRTbdG047m+Q3UlCzgYvqo3yveFqozDRVCXt
 Yv2ZN5dKwI8VvbDu5oQ6kAUpWhsyOeokcawLGEYjXL/RjL8319OiMZ3BhwIevgQttAOnRY
 3evGA6YD/P7nITbDf7UNnwgODM1VSk8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-ZkvmSLX6OXaSHwG0jblr6A-1; Fri, 19 May 2023 04:47:42 -0400
X-MC-Unique: ZkvmSLX6OXaSHwG0jblr6A-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-62387e4de2bso40789876d6.2
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 01:47:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684486062; x=1687078062;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4+lcZOAextRYht0uTCFYzj0UAcbfD5Q2qncxrtjV9oM=;
 b=CRLGX4zY/8W/LkF9betI/QmJxZrE7u4jCaNbmd9dGIkPaJFDtVMjjKK8Upi1HdP/Kn
 qfq2XCoxE3lyBJ/gTLbWpfsJkC8vmejFEXq1u3z/FB3IxiHQRrNPUnHbfHSGrYp0231z
 27EHyURsxNmx5u9h4C6CxtXCZpMxdMSxYQYR7CRZwHClLa3FPXvHnMZJFv+sQTzYlwAW
 jPCDIHRi2hx1xsHN1ypsNkIi1zJd7dBygB6EWoAmhdzWzi2qXvVfZS3Fn60OvDrG3iTn
 DqsTAafYr8Vgylzn9WLHb2ytKk008OULtQ+VCW3jHyBjD4wwn8AycY10gUeUC8AaBAte
 WUqw==
X-Gm-Message-State: AC+VfDww04/lAog0b6i2lS3tOS8j7Iv/lOK0u3v05CNmJMrEldOWkO4A
 PrKXiOXvIOMu2X7d7qLuWrlV/uv+GFsMvRFL4X25XCS7YjaD4GrZdIGLVrPxqywBE77FO4UVjag
 aj7Mh3Clv6B5G7tSLPUKQ7rj9kmGEd6E=
X-Received: by 2002:ad4:5dec:0:b0:621:6ef8:59ba with SMTP id
 jn12-20020ad45dec000000b006216ef859bamr2704303qvb.38.1684486062268; 
 Fri, 19 May 2023 01:47:42 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ64sKolZldKn6g6bVTRQIgomgs3+VocwupvoGIVx00pguNnuPyME5j08DZ4A8HeW1zMrOvGG3EAd3OAJTot2KI=
X-Received: by 2002:ad4:5dec:0:b0:621:6ef8:59ba with SMTP id
 jn12-20020ad45dec000000b006216ef859bamr2704294qvb.38.1684486062111; Fri, 19
 May 2023 01:47:42 -0700 (PDT)
MIME-Version: 1.0
References: <58b8067d-3136-94ed-f53e-2ccd0feb8c75@linaro.org>
 <c30613c6-0521-2b0b-57cd-7c860096cd05@redhat.com>
In-Reply-To: <c30613c6-0521-2b0b-57cd-7c860096cd05@redhat.com>
From: Camilla Conte <cconte@redhat.com>
Date: Fri, 19 May 2023 09:47:06 +0100
Message-ID: <CACPOWh1DADDWHvUABwMiosN=04__7Cr3o2hhvbK=Om49eBkxHQ@mail.gmail.com>
Subject: Re: gitlab shared runner time expired
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cconte@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Hi!

On Fri, May 19, 2023 at 9:35=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
> You should be able to run pipelines almost as usual, just with
>
>     git push -o ci.variable=3DRUNNER_TAG=3Dk8s ...
>
> Camilla, please confirm that this is correct.

Looks good.


