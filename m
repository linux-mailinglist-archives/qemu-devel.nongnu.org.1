Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D9C7E7050
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 18:31:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r18rw-0005vx-Ve; Thu, 09 Nov 2023 12:31:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r18rO-0005nR-No
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 12:30:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r18rN-0001x7-7e
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 12:30:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699551027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=SfH/sspaB4n3fC4cWzjxU7hIDv1sfHzDOKnxbsJ+az63Qe681xqbfNNEG7IDDyJ/ztbG9i
 pL4EUSgWbV8KOXftYIXx41mYlCv5Q4slYyrHIn3qwe9KnPfmmueuDVThm3sUdLIkO82ihO
 MfWB4fCK/dBFm8djkwfI9wRzUTzwaPE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-0LHS7uodMiuYmJdOzeraRA-1; Thu, 09 Nov 2023 12:30:25 -0500
X-MC-Unique: 0LHS7uodMiuYmJdOzeraRA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9e28d82339aso90863966b.2
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 09:30:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699551024; x=1700155824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=W/19EfSSGQc6euUp75mz8D7p80PwqJ/CJnaTv+Hma7BWH62lheLm0q1fOUjF7y8T3f
 /UJm1jjJjLCFNV9nqbLrE1htqK0//iKzU/Wo7Eyi5jQplGUExq3jMbKxo8z0KbUWjsJJ
 6/vP2nR18d2DhJw86nN/Vr5CItoi00qCarXJ+r8QQaDxiH9P84GysbNlThloajy3Abve
 dsXgH4ezVuuw+MzQtaOLuYhMX2XaPfn1tUfNy9xvSeR6HhideuUPBj+NEEreXEckpmSL
 YoMe32PKDewzH6GVjjuSzCSeFd03uo0szIt+bM6wE071vzBDXZNuxngDTc2qJC7e4y+o
 bXtw==
X-Gm-Message-State: AOJu0YyQFUqKNQYU37Ess1INzNfn1Qt855x6axSpLo5i88ZQuH67CRO/
 GbCefowir1GrxzzFQa1eDtE5syn51Qtb8U7U78zdKP8pWikeb36RmTNKGxQSvzS3N01AwaNX82Y
 MxM+JsyDHLWQGJNk=
X-Received: by 2002:a17:907:2da2:b0:9bd:bbc1:1c65 with SMTP id
 gt34-20020a1709072da200b009bdbbc11c65mr5410238ejc.13.1699551024617; 
 Thu, 09 Nov 2023 09:30:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGbkclEnk7i7SPasYK2120zuxKfzhXhr6Q8+n5qrzZStqblY0JKQTXtVT+h3gU0PGawGx+tqA==
X-Received: by 2002:a17:907:2da2:b0:9bd:bbc1:1c65 with SMTP id
 gt34-20020a1709072da200b009bdbbc11c65mr5410214ejc.13.1699551024336; 
 Thu, 09 Nov 2023 09:30:24 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 a3-20020a1709064a4300b009b27d4153cfsm2828223ejv.176.2023.11.09.09.30.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Nov 2023 09:30:23 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org,
 Beraldo Leal <bleal@redhat.com>, Rene Engel <ReneEngel80@emailn.de>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Howard Spoelstra <hsp.cat7@gmail.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH v2 0/2] buildsys: Bump meson version to build on macOS
 Sonoma
Date: Thu,  9 Nov 2023 18:30:20 +0100
Message-ID: <20231109173021.851946-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231109160504.93677-1-philmd@linaro.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

Queued, thanks.

Paolo


