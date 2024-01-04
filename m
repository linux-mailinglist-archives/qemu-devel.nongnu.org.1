Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A1B823A15
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 02:13:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLCHJ-0006dt-Fc; Wed, 03 Jan 2024 20:12:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rLCHH-0006dg-Em
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 20:12:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rLCHF-0001u9-IF
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 20:12:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704330724;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fkNMxuLySyW3pQrBDgcTPooDvsx3boQ81Z//bX1rQ5Q=;
 b=WHVu+Fz+qfYQegH4piEeEy9Io0eYBMMw5Sftsn4ExGsJBOgpKAyAMtaniMxolEqU3OPTAS
 qF5nS3QzhU/VFUD/dieURPgL2mdYIFFk7Y/qJ+erhDbq/B73KFn51L9nK/JyaXHqOiH1CM
 0V4NxrbNWOkqIKFWerOtPvaTxEaomGo=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-jWLQeotdORS5rlnllvpQAQ-1; Wed, 03 Jan 2024 20:12:03 -0500
X-MC-Unique: jWLQeotdORS5rlnllvpQAQ-1
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-6dc056af5e5so14833a34.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 17:12:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704330722; x=1704935522;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fkNMxuLySyW3pQrBDgcTPooDvsx3boQ81Z//bX1rQ5Q=;
 b=gPzCjLkFf1FsTBYqizvcknDFLljZO3Z/+xkmE8BXgErM2H7TJP1YO1BWMkiR9QxaNj
 0cLsNIci3AhWoYnj+czvlu/5mO+rC3fOdrQcA3S3Mcjw70uEqw/5db0aOh7x3+Tn3qtd
 Soed7tqwZPuxXkp5ZXTwDaA8IuyXVTkgaqECitjbw6qu+NntUt+3Hcy/AwJxaMAIgOFv
 vVCBS94hObTywWkFvdfr36VtHDUXkB2SrOn5tmSD1Nu1CPYm9lLWZP9ZWqIURkg03NEP
 R3/eiA91ECzghICT5uWVmcXu/o0tXdjc725HOA2PUG+vbRjnt101RsNhBbkygQogDfSW
 NmFQ==
X-Gm-Message-State: AOJu0Yw7rP2y51L8f/khj9TBlZY7AVDH/QpaHVyba+xCghzVqPp5+g0G
 CMejrJWdgcgnk5lU2PJPEyzCTmXjOVDM3hM56Ol5wyxecSItiMKaxSh4fl+t0hA5QL7ft/mLCxs
 nYA7FYhMxgRqRB9gxLbaJxk0=
X-Received: by 2002:a05:6359:5e83:b0:174:d2c5:e24f with SMTP id
 px3-20020a0563595e8300b00174d2c5e24fmr26614192rwb.2.1704330722146; 
 Wed, 03 Jan 2024 17:12:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEKPZev9YmS/TJINE8eGLWpprrH/EGM9RN+h8v1fUYBvlVQrzgmhAlTn9cRtYnW0d8KPGQt9Q==
X-Received: by 2002:a05:6359:5e83:b0:174:d2c5:e24f with SMTP id
 px3-20020a0563595e8300b00174d2c5e24fmr26614178rwb.2.1704330721645; 
 Wed, 03 Jan 2024 17:12:01 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 fn24-20020a056a002fd800b006d9974a87fcsm20033773pfb.215.2024.01.03.17.11.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jan 2024 17:12:01 -0800 (PST)
Date: Thu, 4 Jan 2024 09:11:56 +0800
From: Peter Xu <peterx@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: QEMU developers call
Message-ID: <ZZYF3KmzNWPadIl9@x1n>
References: <87mstno2ob.fsf@secure.mitica> <ZZS9-H2g6qjlY-4_@x1n>
 <87ttnuhbov.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ttnuhbov.fsf@draig.linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.601,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jan 03, 2024 at 11:57:04AM +0000, Alex Bennée wrote:
> Another way of saying M-x rot13-region ;-)

Ah.. :)

        ROT13 is used in online forums as a means of hiding spoilers,
        punchlines, puzzle solutions, and offensive materials from the
        casual glance.

Thanks for sharing!

-- 
Peter Xu


