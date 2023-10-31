Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 098A27DCFDC
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 16:04:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxqH1-0001hM-4p; Tue, 31 Oct 2023 11:03:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxqGy-0001gD-MH
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 11:03:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxqGr-0005ay-0e
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 11:03:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698764575;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D1cWTYuelfAVyYkQePGe8s3yQGLFFYUlROrcPLCYR9E=;
 b=NhJ6XRIk1OhS60XC/37eR070VEoXU5g9NXquiMgpMwCjLFisX8nQD8Rv/JpPaEiY1/Iatw
 vZK5Xnji3fQTm+xG+BdojSMyoRTaPOnAB0WQWQPpgQLjdIWeUZe7bh/frlbp5eCW3AVECy
 AetzT6upxIWNDlhDONRXZkOPNJb+i64=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-CY30kZOfOgKzIaHFGD-I1A-1; Tue, 31 Oct 2023 11:02:53 -0400
X-MC-Unique: CY30kZOfOgKzIaHFGD-I1A-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2c50c873604so64879951fa.1
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 08:02:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698764572; x=1699369372;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D1cWTYuelfAVyYkQePGe8s3yQGLFFYUlROrcPLCYR9E=;
 b=kaC+G0hgXKI0F+rbQOurNRfiQm5VWJZvY5T7De5kE180wuvgu7NLQYXZmSW1HkJaW6
 mMPe3JvcVvYvUgCIfVjOwUBqx6ceFTA2kmSH7EHUMqFrSaZjsSrfWNp2oCt2cx7JG4qh
 6CR/S2GMG+5CqNuLnrk27I7dO/NPI40E37ENwT3nk4zp/7OAV4Oocu5cB+AFX/nPI9j1
 0OqFexwSPQRfAJqhiBhJkLqgbPrCwoRpE0RnIOmnKfY6t+WCtAL9zQPZ0nmEsXdhCeng
 AuOUCHTTEWvhzS8q9GETDIj+ysz1pelBiXtEiv833qv3Xe7wmpLzpxqOJZLXYuq1ZcnJ
 tggw==
X-Gm-Message-State: AOJu0Yxi84s5CsH5QsbQOLTmTcPd4hSKABfEWfhPj0MXPdCqCG+AZ4ij
 EHL18Ejpp5PZ4GdAYFByj3e1UdZCjZlZfmOa9wtApQVbtLIGxk/DE7Q+gk4NC7i2Emx9kzZ76Py
 5QzllD5q/OCaIXBk=
X-Received: by 2002:a05:651c:2122:b0:2c5:a1b0:d95a with SMTP id
 a34-20020a05651c212200b002c5a1b0d95amr11542887ljq.14.1698764572500; 
 Tue, 31 Oct 2023 08:02:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhVGUtjz87WFDTz6t4+8vdZXA5BquvkPx/WBG7guzvFy43kSdmciLkEu1CzC4TQlfyKDX01w==
X-Received: by 2002:a05:651c:2122:b0:2c5:a1b0:d95a with SMTP id
 a34-20020a05651c212200b002c5a1b0d95amr11542872ljq.14.1698764572283; 
 Tue, 31 Oct 2023 08:02:52 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 m41-20020a05600c3b2900b00401e32b25adsm2046367wms.4.2023.10.31.08.02.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 08:02:51 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  prerna.saxena@nutanix.com,  dgilbert@redhat.com,
 pbonzini@redhat.com,  berrange@redhat.com,  armbru@redhat.com,
 eblake@redhat.com,  manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com,  Het Gala <het.gala@nutanix.com>,  Peter
 Xu <peterx@redhat.com>,  Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v15 04/14] fixup! migration: convert migration 'uri'
 into 'MigrateAddress'
In-Reply-To: <20231023182053.8711-5-farosas@suse.de> (Fabiano Rosas's message
 of "Mon, 23 Oct 2023 15:20:43 -0300")
References: <20231023182053.8711-1-farosas@suse.de>
 <20231023182053.8711-5-farosas@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Tue, 31 Oct 2023 16:02:51 +0100
Message-ID: <87wmv26dic.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Fabiano Rosas <farosas@suse.de> wrote:
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

Merged with previous.


