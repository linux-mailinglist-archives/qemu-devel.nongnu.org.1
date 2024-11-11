Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9C59C4130
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Nov 2024 15:44:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAVcd-0000a5-6O; Mon, 11 Nov 2024 09:42:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1tAVca-0000Zr-CV
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 09:42:28 -0500
Received: from oxygen.pond.sub.org ([94.130.129.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1tAVcY-00015B-Gx
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 09:42:28 -0500
Received: from blackfin.pond.sub.org (p50902f8c.dip0.t-ipconnect.de
 [80.144.47.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by oxygen.pond.sub.org (Postfix) with ESMTPSA id 8AE8420502;
 Mon, 11 Nov 2024 15:47:14 +0100 (CET)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A02D621E6A28; Mon, 11 Nov 2024 15:42:17 +0100 (CET)
Resent-To: zhao1.liu@intel.com, qemu-devel@nongnu.org,
 steven.sistare@oracle.com
Resent-From: Markus Armbruster <armbru@pond.sub.org>
Resent-Date: Mon, 11 Nov 2024 15:42:17 +0100
Resent-Message-ID: <87r07hq1bq.fsf@pond.sub.org>
X-From-Line: armbru@redhat.com Mon Nov 11 15:38:18 2024
Received: from imap.gmail.com ([2a00:1450:400c:c06::6d]:993) by
 dusky.pond.sub.org with IMAP4-SSL getmail6 msgid:11/291736; 11 Nov 2024
 14:38:18 -0000
Received: by 2002:a05:6200:3704:b0:57d:c829:e0f5 with SMTP id y4csp5598547qnx; 
 Mon, 11 Nov 2024 05:19:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731331179; x=1731935979;
 h=message-id:content-transfer-encoding:mime-version:auto-submitted:to
 :subject:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j/9fP5McdWBjAMqClUNLPHXkPwh8aKAQq1U4h5zNnSQ=;
 b=xMO1KdDa0WTkOgtzSxuWHV6HHdaPAmHGM4expQUM2MccrwgreMoOo43ka/uJTsG+oc
 +506zJ0PYfBJzzqHAyVt3txKN/66R01P8aEYecKIhDfF6GqSCpAwPVL+N1yAOb4+Qxjk
 /2OGAnqW58r72xTny3a6u/tknipBltFoqdPXbwzotap4FwydnuL0scB75pUg8Lzcog0b
 IHVvcUxrXKL7BxHJsBlXFBjx88WSFD8PUVEUuiSVoiiX2YMDw1SaejKi0CnvLtYxO4hE
 bv6dtLjXLQRSecFXj2uAZ/JpMJAcN+LCibomEvfXmaUIhTW2E25M3lR/wjVFa2peD4aJ
 IHFA==
X-Received: by 2002:a05:6402:5256:b0:5ce:dff4:49bf with SMTP id
 4fb4d7f45d1cf-5cf0a45e16cmr9601828a12.29.1731331178127;
 Mon, 11 Nov 2024 05:19:38 -0800 (PST)
X-Gm-Message-State: AOJu0YweIfkICpkuB0qDLvBkjEcxwDwL59eCOm7/MvROPLOsHTnhu8+W
 ajKeKkVg8pkFqeXkdAORoWyuYqKKJQaZBdXS6Wv4uy7hXWCx6WHDKmDDRSyztL9kQTWuhrfx4hd
 LWAsgUUZeSoJrpX6FSSFCAWgsQWJKJvZJI7NQBQWK0h7/bdMiwk9Z/LXx4fiVDo6f5wbl7yaetL
 1XwkGV8BQR03R/Woqx6Tv90xTkUw==
X-Google-Smtp-Source: AGHT+IF2TXRmMvys6PXF28RExFow4L2kyIKqU8b10FPF1wwXsWQYq8TxNdAsTcWCSr0EeXqRpKJDFw==
X-Received: by 2002:a05:6402:5256:b0:5ce:dff4:49bf with SMTP id
 4fb4d7f45d1cf-5cf0a45e16cmr9601811a12.29.1731331177668;
 Mon, 11 Nov 2024 05:19:37 -0800 (PST)
Received: from blackfin.pond.sub.org
 (p200300d36f0ee700d643b08a25dce8c7.dip0.t-ipconnect.de.
 [2003:d3:6f0e:e700:d643:b08a:25dc:e8c7])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cf03b5d77csm4873798a12.5.2024.11.11.05.19.37
 for <armbru@redhat.com>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Nov 2024 05:19:37 -0800 (PST)
From: Mail Delivery System <armbru@redhat.com>
X-Google-Original-From: Mail Delivery System <MAILER-DAEMON@pond.sub.org>
Received: by blackfin.pond.sub.org (Postfix)
 id 9DFA521E691E; Mon, 11 Nov 2024 14:19:36 +0100 (CET)
Date: Mon, 11 Nov 2024 14:19:36 +0100 (CET)
Subject: Undelivered Mail Returned to Sender
To: armbru@redhat.com
Auto-Submitted: auto-replied
MIME-Version: 1.0
Content-Type: multipart/report; report-type=delivery-status;
 boundary="927C321E6A28.1731331176/blackfin.pond.sub.org"
Content-Transfer-Encoding: 8bit
Message-Id: <20241111131936.9DFA521E691E@blackfin.pond.sub.org>
X-getmail-retrieved-from-mailbox: [Gmail]/All Mail
X-GMAIL-LABELS: "\\Inbox" "\\Sent"
X-GMAIL-THRID: 1814977678327726508
X-GMAIL-MSGID: 1815432320446976696
Lines: 86
Received-SPF: pass client-ip=94.130.129.15; envelope-from=armbru@pond.sub.org;
 helo=oxygen.pond.sub.org
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

This is a MIME-encapsulated message.

--927C321E6A28.1731331176/blackfin.pond.sub.org
Content-Description: Notification
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

This is the mail system at host blackfin.pond.sub.org.

I'm sorry to have to inform you that your message could not
be delivered to one or more recipients. It's attached below.

For further assistance, please send mail to postmaster.

If you do so, please include this problem report. You can
delete your own text from the attached returned message.

                   The mail system

<zhao1.liu@intel.com>: Host or domain name not found. Name service error for
    name=smtp.corp.redhat.com type=AAAA: Host not found

<qemu-devel@nongnu.org>: Host or domain name not found. Name service error for
    name=smtp.corp.redhat.com type=AAAA: Host not found

<steven.sistare@oracle.com>: Host or domain name not found. Name service error
    for name=smtp.corp.redhat.com type=AAAA: Host not found

--927C321E6A28.1731331176/blackfin.pond.sub.org
Content-Description: Delivery report
Content-Type: message/delivery-status

Reporting-MTA: dns; blackfin.pond.sub.org
X-Postfix-Queue-ID: 927C321E6A28
X-Postfix-Sender: rfc822; armbru@redhat.com
Arrival-Date: Mon, 11 Nov 2024 14:19:26 +0100 (CET)

Final-Recipient: rfc822; zhao1.liu@intel.com
Original-Recipient: rfc822;zhao1.liu@intel.com
Action: failed
Status: 5.4.4
Diagnostic-Code: X-Postfix; Host or domain name not found. Name service error
    for name=smtp.corp.redhat.com type=AAAA: Host not found

Final-Recipient: rfc822; qemu-devel@nongnu.org
Original-Recipient: rfc822;qemu-devel@nongnu.org
Action: failed
Status: 5.4.4
Diagnostic-Code: X-Postfix; Host or domain name not found. Name service error
    for name=smtp.corp.redhat.com type=AAAA: Host not found

Final-Recipient: rfc822; steven.sistare@oracle.com
Original-Recipient: rfc822;steven.sistare@oracle.com
Action: failed
Status: 5.4.4
Diagnostic-Code: X-Postfix; Host or domain name not found. Name service error
    for name=smtp.corp.redhat.com type=AAAA: Host not found

--927C321E6A28.1731331176/blackfin.pond.sub.org
Content-Description: Undelivered Message
Content-Type: message/rfc822
Content-Transfer-Encoding: 8bit

Return-Path: <armbru@redhat.com>
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 927C321E6A28; Mon, 11 Nov 2024 14:19:26 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,  Steve Sistare <steven.sistare@oracle.com>,
  Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Peter Xu
 <peterx@redhat.com>,
  Zhao Liu <zhao1.liu@intel.com>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: Why the wait for reviews / advice from armbru?
In-Reply-To: <87v7x0o75w.fsf@pond.sub.org> (Markus Armbruster's message of
	"Wed, 06 Nov 2024 13:53:15 +0100")
References: <87v7x0o75w.fsf@pond.sub.org>
Date: Mon, 11 Nov 2024 14:19:26 +0100
Message-ID: <8734jxrjq9.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain

Thank you all for your kindness, I truly apprecate it!

--927C321E6A28.1731331176/blackfin.pond.sub.org--


