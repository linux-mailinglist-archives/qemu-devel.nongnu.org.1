Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F56E7C7F2D
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:00:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrCyO-0003H5-J2; Fri, 13 Oct 2023 03:52:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrCxa-0007pA-CX
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:51:50 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrCxL-00057t-7x
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:51:50 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3296b3f03e5so1614315f8f.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183489; x=1697788289; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y2BbUNGw5oZtiwFs9bl78044TvGJmcMQmCrDFpABE8c=;
 b=XJVMi2kaRiaeuQPpPrNLim8W9b9NFuUZKwhYOpstlFHSWMDfwcKkK34Hs/Wiv5TtfY
 gyXbqpBPVODNOQZZjozrm9XPEdqGcCsptXd1bHhjOnPNanoFA5lmkfaC9d6q/XqFtFFE
 0dbotDqMJtZ11Ssha/KPOIlbi6jN4KfTX5imYH8vZTU8ofhkN4XUCkf8Hvw8O6WOYpsm
 JmWVzxNNsKrr9SGT27CnBPEXZUvzTJ8/4jbxX9O89T4oBsDwiT2glxZGJHc1QUKl/k/j
 oH3zzpuw8pLMCWTyCsTggwRb7MMA74/Q+tsbRMa/WyPJs25zL20ILsRHKjP5rRSjTVhB
 1z/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183489; x=1697788289;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y2BbUNGw5oZtiwFs9bl78044TvGJmcMQmCrDFpABE8c=;
 b=KI/x7+use95VNFcbcapU0SUFQRO5gxiwUs6P4vWlwN7liblGGx0RCD64b5tZZUsST3
 uWwP9C6ti1zfWDmABfnYaEyx5Xn9XCdr5ncwsA8em6o8id1WI+fMql4jGlhIKFWPhpas
 mcbfoeya+YF+xqOO3+L/RSLg2+p5p2AGzSfT0Lt2m0D6WIRxNr9VSSCoBKWzB7hVIQjZ
 3WaALt6CqIpqGQYB9Pw2DZ8VqY3DbXFlURLjWQOo+2LxNXF97Z2ip36f/e0rDm/e00yb
 3RmYMgDEhYS6/ALtqTMBM2Z/jTwii5GOZq2GDdDBQRte8NIllJq3foJ7+/rNZee3GNM7
 Ct5g==
X-Gm-Message-State: AOJu0YyCZ1WctiEug+DZjEAwLiyZ8kiyUaLM69qbAPROtBx5etE+aR4r
 Eyll6hHfAuF6xGahKlTgcH5swEvCNOXt53f0ja4=
X-Google-Smtp-Source: AGHT+IF9778WSZJpN2IMDwIUruBU30TXYd4JdSqvLV2O81YfNOAOh4Ev4tMZEP/uWRXR+69M+5ie1g==
X-Received: by 2002:a5d:42d2:0:b0:314:1b36:f440 with SMTP id
 t18-20020a5d42d2000000b003141b36f440mr19852372wrr.70.1697183488658; 
 Fri, 13 Oct 2023 00:51:28 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 m8-20020adfa3c8000000b0032d7fde2d3csm7990663wrb.79.2023.10.13.00.51.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:51:28 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-block@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [RFC PATCH 45/75] disas: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:47:57 +0300
Message-Id: <d3b15834823233ee855b1d4c093de9d03a37b8e4.1697034504.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697034504.git.manos.pitsidianakis@linaro.org>
References: <cover.1697034504.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 disas/hppa.c  | 4 ++--
 disas/m68k.c  | 2 +-
 disas/sh4.c   | 4 +++-
 disas/sparc.c | 2 +-
 4 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/disas/hppa.c b/disas/hppa.c
index dcf9a47f34..1a2bdb8d39 100644
--- a/disas/hppa.c
+++ b/disas/hppa.c
@@ -1954,878 +1954,878 @@ int
 print_insn_hppa (bfd_vma memaddr, disassemble_info *info)
 {
   bfd_byte buffer[4];
   unsigned int insn, i;
 
   {
     int status =
       (*info->read_memory_func) (memaddr, buffer, sizeof (buffer), info);
     if (status != 0)
       {
 	(*info->memory_error_func) (status, memaddr, info);
 	return -1;
       }
   }
 
   insn = bfd_getb32 (buffer);
 
   for (i = 0; i < NUMOPCODES; ++i)
     {
       const struct pa_opcode *opcode = &pa_opcodes[i];
 
       if ((insn & opcode->mask) == opcode->match)
 	{
 	  const char *s;
 #ifndef BFD64
 	  if (opcode->arch == pa20w)
 	    continue;
 #endif
 	  (*info->fprintf_func) (info->stream, "%s", opcode->name);
 
 	  if (!strchr ("cfCY?-+nHNZFIuv{", opcode->args[0]))
 	    (*info->fprintf_func) (info->stream, " ");
 	  for (s = opcode->args; *s != '\0'; ++s)
 	    {
 	      switch (*s)
 		{
 		case 'x':
 		  fput_reg (GET_FIELD (insn, 11, 15), info);
 		  break;
 		case 'a':
 		case 'b':
 		  fput_reg (GET_FIELD (insn, 6, 10), info);
 		  break;
 		case '^':
 		  fput_creg (GET_FIELD (insn, 6, 10), info);
 		  break;
 		case 't':
 		  fput_reg (GET_FIELD (insn, 27, 31), info);
 		  break;
 
 		  /* Handle floating point registers.  */
 		case 'f':
 		  switch (*++s)
 		    {
 		    case 't':
 		      fput_fp_reg (GET_FIELD (insn, 27, 31), info);
 		      break;
 		    case 'T':
 		      if (GET_FIELD (insn, 25, 25))
 			fput_fp_reg_r (GET_FIELD (insn, 27, 31), info);
 		      else
 			fput_fp_reg (GET_FIELD (insn, 27, 31), info);
 		      break;
 		    case 'a':
 		      if (GET_FIELD (insn, 25, 25))
 			fput_fp_reg_r (GET_FIELD (insn, 6, 10), info);
 		      else
 			fput_fp_reg (GET_FIELD (insn, 6, 10), info);
 		      break;
 
 		      /* 'fA' will not generate a space before the register
 			 name.  Normally that is fine.  Except that it
 			 causes problems with xmpyu which has no FP format
 			 completer.  */
 		    case 'X':
 		      fputs_filtered (" ", info);
-		      /* FALLTHRU */
+		      fallthrough;
 
 		    case 'A':
 		      if (GET_FIELD (insn, 24, 24))
 			fput_fp_reg_r (GET_FIELD (insn, 6, 10), info);
 		      else
 			fput_fp_reg (GET_FIELD (insn, 6, 10), info);
 		      break;
 		    case 'b':
 		      if (GET_FIELD (insn, 25, 25))
 			fput_fp_reg_r (GET_FIELD (insn, 11, 15), info);
 		      else
 			fput_fp_reg (GET_FIELD (insn, 11, 15), info);
 		      break;
 		    case 'B':
 		      if (GET_FIELD (insn, 19, 19))
 			fput_fp_reg_r (GET_FIELD (insn, 11, 15), info);
 		      else
 			fput_fp_reg (GET_FIELD (insn, 11, 15), info);
 		      break;
 		    case 'C':
 		      {
 			int reg = GET_FIELD (insn, 21, 22);
 			reg |= GET_FIELD (insn, 16, 18) << 2;
 			if (GET_FIELD (insn, 23, 23) != 0)
 			  fput_fp_reg_r (reg, info);
 			else
 			  fput_fp_reg (reg, info);
 			break;
 		      }
 		    case 'i':
 		      {
 			int reg = GET_FIELD (insn, 6, 10);
 
 			reg |= (GET_FIELD (insn, 26, 26) << 4);
 			fput_fp_reg (reg, info);
 			break;
 		      }
 		    case 'j':
 		      {
 			int reg = GET_FIELD (insn, 11, 15);
 
 			reg |= (GET_FIELD (insn, 26, 26) << 4);
 			fput_fp_reg (reg, info);
 			break;
 		      }
 		    case 'k':
 		      {
 			int reg = GET_FIELD (insn, 27, 31);
 
 			reg |= (GET_FIELD (insn, 26, 26) << 4);
 			fput_fp_reg (reg, info);
 			break;
 		      }
 		    case 'l':
 		      {
 			int reg = GET_FIELD (insn, 21, 25);
 
 			reg |= (GET_FIELD (insn, 26, 26) << 4);
 			fput_fp_reg (reg, info);
 			break;
 		      }
 		    case 'm':
 		      {
 			int reg = GET_FIELD (insn, 16, 20);
 
 			reg |= (GET_FIELD (insn, 26, 26) << 4);
 			fput_fp_reg (reg, info);
 			break;
 		      }
 
 		      /* 'fe' will not generate a space before the register
 			 name.  Normally that is fine.  Except that it
 			 causes problems with fstw fe,y(b) which has no FP
 			 format completer.  */
 		    case 'E':
 		      fputs_filtered (" ", info);
-		      /* FALLTHRU */
+		      fallthrough;
 
 		    case 'e':
 		      if (GET_FIELD (insn, 30, 30))
 			fput_fp_reg_r (GET_FIELD (insn, 11, 15), info);
 		      else
 			fput_fp_reg (GET_FIELD (insn, 11, 15), info);
 		      break;
 		    case 'x':
 		      fput_fp_reg (GET_FIELD (insn, 11, 15), info);
 		      break;
 		    }
 		  break;
 
 		case '5':
 		  fput_const (extract_5_load (insn), info);
 		  break;
 		case 's':
 		  {
 		    int space = GET_FIELD (insn, 16, 17);
 		    /* Zero means implicit addressing, not use of sr0.  */
 		    if (space != 0)
 		      (*info->fprintf_func) (info->stream, "sr%d", space);
 		  }
 		  break;
 
 		case 'S':
 		  (*info->fprintf_func) (info->stream, "sr%d",
 					 extract_3 (insn));
 		  break;
 
 		  /* Handle completers.  */
 		case 'c':
 		  switch (*++s)
 		    {
 		    case 'x':
 		      (*info->fprintf_func)
 			(info->stream, "%s",
 			 index_compl_names[GET_COMPL (insn)]);
 		      break;
 		    case 'X':
 		      (*info->fprintf_func)
 			(info->stream, "%s ",
 			 index_compl_names[GET_COMPL (insn)]);
 		      break;
 		    case 'm':
 		      (*info->fprintf_func)
 			(info->stream, "%s",
 			 short_ldst_compl_names[GET_COMPL (insn)]);
 		      break;
 		    case 'M':
 		      (*info->fprintf_func)
 			(info->stream, "%s ",
 			 short_ldst_compl_names[GET_COMPL (insn)]);
 		      break;
 		    case 'A':
 		      (*info->fprintf_func)
 			(info->stream, "%s ",
 			 short_bytes_compl_names[GET_COMPL (insn)]);
 		      break;
 		    case 's':
 		      (*info->fprintf_func)
 			(info->stream, "%s",
 			 short_bytes_compl_names[GET_COMPL (insn)]);
 		      break;
 		    case 'c':
 		    case 'C':
 		      switch (GET_FIELD (insn, 20, 21))
 			{
 			case 1:
 			  (*info->fprintf_func) (info->stream, ",bc ");
 			  break;
 			case 2:
 			  (*info->fprintf_func) (info->stream, ",sl ");
 			  break;
 			default:
 			  (*info->fprintf_func) (info->stream, " ");
 			}
 		      break;
 		    case 'd':
 		      switch (GET_FIELD (insn, 20, 21))
 			{
 			case 1:
 			  (*info->fprintf_func) (info->stream, ",co ");
 			  break;
 			default:
 			  (*info->fprintf_func) (info->stream, " ");
 			}
 		      break;
 		    case 'o':
 		      (*info->fprintf_func) (info->stream, ",o");
 		      break;
 		    case 'g':
 		      (*info->fprintf_func) (info->stream, ",gate");
 		      break;
 		    case 'p':
 		      (*info->fprintf_func) (info->stream, ",l,push");
 		      break;
 		    case 'P':
 		      (*info->fprintf_func) (info->stream, ",pop");
 		      break;
 		    case 'l':
 		    case 'L':
 		      (*info->fprintf_func) (info->stream, ",l");
 		      break;
 		    case 'w':
 		      (*info->fprintf_func)
 			(info->stream, "%s ",
 			 read_write_names[GET_FIELD (insn, 25, 25)]);
 		      break;
 		    case 'W':
 		      (*info->fprintf_func) (info->stream, ",w ");
 		      break;
 		    case 'r':
 		      if (GET_FIELD (insn, 23, 26) == 5)
 			(*info->fprintf_func) (info->stream, ",r");
 		      break;
 		    case 'Z':
 		      if (GET_FIELD (insn, 26, 26))
 			(*info->fprintf_func) (info->stream, ",m ");
 		      else
 			(*info->fprintf_func) (info->stream, " ");
 		      break;
 		    case 'i':
 		      if (GET_FIELD (insn, 25, 25))
 			(*info->fprintf_func) (info->stream, ",i");
 		      break;
 		    case 'z':
 		      if (!GET_FIELD (insn, 21, 21))
 			(*info->fprintf_func) (info->stream, ",z");
 		      break;
 		    case 'a':
 		      (*info->fprintf_func)
 			(info->stream, "%s",
 			 add_compl_names[GET_FIELD (insn, 20, 21)]);
 		      break;
 		    case 'Y':
 		      (*info->fprintf_func)
 			(info->stream, ",dc%s",
 			 add_compl_names[GET_FIELD (insn, 20, 21)]);
 		      break;
 		    case 'y':
 		      (*info->fprintf_func)
 			(info->stream, ",c%s",
 			 add_compl_names[GET_FIELD (insn, 20, 21)]);
 		      break;
 		    case 'v':
 		      if (GET_FIELD (insn, 20, 20))
 			(*info->fprintf_func) (info->stream, ",tsv");
 		      break;
 		    case 't':
 		      (*info->fprintf_func) (info->stream, ",tc");
 		      if (GET_FIELD (insn, 20, 20))
 			(*info->fprintf_func) (info->stream, ",tsv");
 		      break;
 		    case 'B':
 		      (*info->fprintf_func) (info->stream, ",db");
 		      if (GET_FIELD (insn, 20, 20))
 			(*info->fprintf_func) (info->stream, ",tsv");
 		      break;
 		    case 'b':
 		      (*info->fprintf_func) (info->stream, ",b");
 		      if (GET_FIELD (insn, 20, 20))
 			(*info->fprintf_func) (info->stream, ",tsv");
 		      break;
 		    case 'T':
 		      if (GET_FIELD (insn, 25, 25))
 			(*info->fprintf_func) (info->stream, ",tc");
 		      break;
 		    case 'S':
 		      /* EXTRD/W has a following condition.  */
 		      if (*(s + 1) == '?')
 			(*info->fprintf_func)
 			  (info->stream, "%s",
 			   signed_unsigned_names[GET_FIELD (insn, 21, 21)]);
 		      else
 			(*info->fprintf_func)
 			  (info->stream, "%s ",
 			   signed_unsigned_names[GET_FIELD (insn, 21, 21)]);
 		      break;
 		    case 'h':
 		      (*info->fprintf_func)
 			(info->stream, "%s",
 			 mix_half_names[GET_FIELD (insn, 17, 17)]);
 		      break;
 		    case 'H':
 		      (*info->fprintf_func)
 			(info->stream, "%s ",
 			 saturation_names[GET_FIELD (insn, 24, 25)]);
 		      break;
 		    case '*':
 		      (*info->fprintf_func)
 			(info->stream, ",%d%d%d%d ",
 			 GET_FIELD (insn, 17, 18), GET_FIELD (insn, 20, 21),
 			 GET_FIELD (insn, 22, 23), GET_FIELD (insn, 24, 25));
 		      break;
 
 		    case 'q':
 		      {
 			int m, a;
 
 			m = GET_FIELD (insn, 28, 28);
 			a = GET_FIELD (insn, 29, 29);
 
 			if (m && !a)
 			  fputs_filtered (",ma ", info);
 			else if (m && a)
 			  fputs_filtered (",mb ", info);
 			else
 			  fputs_filtered (" ", info);
 			break;
 		      }
 
 		    case 'J':
 		      {
 			int opc = GET_FIELD (insn, 0, 5);
 
 			if (opc == 0x16 || opc == 0x1e)
 			  {
 			    if (GET_FIELD (insn, 29, 29) == 0)
 			      fputs_filtered (",ma ", info);
 			    else
 			      fputs_filtered (",mb ", info);
 			  }
 			else
 			  fputs_filtered (" ", info);
 			break;
 		      }
 
 		    case 'e':
 		      {
 			int opc = GET_FIELD (insn, 0, 5);
 
 			if (opc == 0x13 || opc == 0x1b)
 			  {
 			    if (GET_FIELD (insn, 18, 18) == 1)
 			      fputs_filtered (",mb ", info);
 			    else
 			      fputs_filtered (",ma ", info);
 			  }
 			else if (opc == 0x17 || opc == 0x1f)
 			  {
 			    if (GET_FIELD (insn, 31, 31) == 1)
 			      fputs_filtered (",ma ", info);
 			    else
 			      fputs_filtered (",mb ", info);
 			  }
 			else
 			  fputs_filtered (" ", info);
 
 			break;
 		      }
 		    }
 		  break;
 
 		  /* Handle conditions.  */
 		case '?':
 		  {
 		    s++;
 		    switch (*s)
 		      {
 		      case 'f':
 			(*info->fprintf_func)
 			  (info->stream, "%s ",
 			   float_comp_names[GET_FIELD (insn, 27, 31)]);
 			break;
 
 			/* These four conditions are for the set of instructions
 			   which distinguish true/false conditions by opcode
 			   rather than by the 'f' bit (sigh): comb, comib,
 			   addb, addib.  */
 		      case 't':
 			fputs_filtered
 			  (compare_cond_names[GET_FIELD (insn, 16, 18)], info);
 			break;
 		      case 'n':
 			fputs_filtered
 			  (compare_cond_names[GET_FIELD (insn, 16, 18)
 					      + GET_FIELD (insn, 4, 4) * 8],
 			   info);
 			break;
 		      case 'N':
 			fputs_filtered
 			  (compare_cond_64_names[GET_FIELD (insn, 16, 18)
 						 + GET_FIELD (insn, 2, 2) * 8],
 			   info);
 			break;
 		      case 'Q':
 			fputs_filtered
 			  (cmpib_cond_64_names[GET_FIELD (insn, 16, 18)],
 			   info);
 			break;
 		      case '@':
 			fputs_filtered
 			  (add_cond_names[GET_FIELD (insn, 16, 18)
 					  + GET_FIELD (insn, 4, 4) * 8],
 			   info);
 			break;
 		      case 's':
 			(*info->fprintf_func)
 			  (info->stream, "%s ",
 			   compare_cond_names[GET_COND (insn)]);
 			break;
 		      case 'S':
 			(*info->fprintf_func)
 			  (info->stream, "%s ",
 			   compare_cond_64_names[GET_COND (insn)]);
 			break;
 		      case 'a':
 			(*info->fprintf_func)
 			  (info->stream, "%s ",
 			   add_cond_names[GET_COND (insn)]);
 			break;
 		      case 'A':
 			(*info->fprintf_func)
 			  (info->stream, "%s ",
 			   add_cond_64_names[GET_COND (insn)]);
 			break;
 		      case 'd':
 			(*info->fprintf_func)
 			  (info->stream, "%s",
 			   add_cond_names[GET_FIELD (insn, 16, 18)]);
 			break;
 
 		      case 'W':
 			(*info->fprintf_func)
 			  (info->stream, "%s",
 			   wide_add_cond_names[GET_FIELD (insn, 16, 18) +
 					       GET_FIELD (insn, 4, 4) * 8]);
 			break;
 
 		      case 'l':
 			(*info->fprintf_func)
 			  (info->stream, "%s ",
 			   logical_cond_names[GET_COND (insn)]);
 			break;
 		      case 'L':
 			(*info->fprintf_func)
 			  (info->stream, "%s ",
 			   logical_cond_64_names[GET_COND (insn)]);
 			break;
 		      case 'u':
 			(*info->fprintf_func)
 			  (info->stream, "%s ",
 			   unit_cond_names[GET_COND (insn)]);
 			break;
 		      case 'U':
 			(*info->fprintf_func)
 			  (info->stream, "%s ",
 			   unit_cond_64_names[GET_COND (insn)]);
 			break;
 		      case 'y':
 		      case 'x':
 		      case 'b':
 			(*info->fprintf_func)
 			  (info->stream, "%s",
 			   shift_cond_names[GET_FIELD (insn, 16, 18)]);
 
 			/* If the next character in args is 'n', it will handle
 			   putting out the space.  */
 			if (s[1] != 'n')
 			  (*info->fprintf_func) (info->stream, " ");
 			break;
 		      case 'X':
 			(*info->fprintf_func)
 			  (info->stream, "%s ",
 			   shift_cond_64_names[GET_FIELD (insn, 16, 18)]);
 			break;
 		      case 'B':
 			(*info->fprintf_func)
 			  (info->stream, "%s",
 			   bb_cond_64_names[GET_FIELD (insn, 16, 16)]);
 
 			/* If the next character in args is 'n', it will handle
 			   putting out the space.  */
 			if (s[1] != 'n')
 			  (*info->fprintf_func) (info->stream, " ");
 			break;
 		      }
 		    break;
 		  }
 
 		case 'V':
 		  fput_const (extract_5_store (insn), info);
 		  break;
 		case 'r':
 		  fput_const (extract_5r_store (insn), info);
 		  break;
 		case 'R':
 		  fput_const (extract_5R_store (insn), info);
 		  break;
 		case 'U':
 		  fput_const (extract_10U_store (insn), info);
 		  break;
 		case 'B':
 		case 'Q':
 		  fput_const (extract_5Q_store (insn), info);
 		  break;
 		case 'i':
 		  fput_const (extract_11 (insn), info);
 		  break;
 		case 'j':
 		  fput_const (extract_14 (insn), info);
 		  break;
 		case 'k':
 		  fputs_filtered ("L%", info);
 		  fput_const (extract_21 (insn), info);
 		  break;
 		case '<':
 		case 'l':
 		  /* 16-bit long disp., PA2.0 wide only.  */
 		  fput_const (extract_16 (insn), info);
 		  break;
 		case 'n':
 		  if (insn & 0x2)
 		    (*info->fprintf_func) (info->stream, ",n ");
 		  else
 		    (*info->fprintf_func) (info->stream, " ");
 		  break;
 		case 'N':
 		  if ((insn & 0x20) && s[1])
 		    (*info->fprintf_func) (info->stream, ",n ");
 		  else if (insn & 0x20)
 		    (*info->fprintf_func) (info->stream, ",n");
 		  else if (s[1])
 		    (*info->fprintf_func) (info->stream, " ");
 		  break;
 		case 'w':
 		  (*info->print_address_func)
 		    (memaddr + 8 + extract_12 (insn), info);
 		  break;
 		case 'W':
 		  /* 17 bit PC-relative branch.  */
 		  (*info->print_address_func)
 		    ((memaddr + 8 + extract_17 (insn)), info);
 		  break;
 		case 'z':
 		  /* 17 bit displacement.  This is an offset from a register
 		     so it gets disasssembled as just a number, not any sort
 		     of address.  */
 		  fput_const (extract_17 (insn), info);
 		  break;
 
 		case 'Z':
 		  /* addil %r1 implicit output.  */
 		  fputs_filtered ("r1", info);
 		  break;
 
 		case 'Y':
 		  /* be,l %sr0,%r31 implicit output.  */
 		  fputs_filtered ("sr0,r31", info);
 		  break;
 
 		case '@':
 		  (*info->fprintf_func) (info->stream, "0");
 		  break;
 
 		case '.':
 		  (*info->fprintf_func) (info->stream, "%d",
 					 GET_FIELD (insn, 24, 25));
 		  break;
 		case '*':
 		  (*info->fprintf_func) (info->stream, "%d",
 					 GET_FIELD (insn, 22, 25));
 		  break;
 		case '!':
 		  fputs_filtered ("sar", info);
 		  break;
 		case 'p':
 		  (*info->fprintf_func) (info->stream, "%d",
 					 31 - GET_FIELD (insn, 22, 26));
 		  break;
 		case '~':
 		  {
 		    int num;
 		    num = GET_FIELD (insn, 20, 20) << 5;
 		    num |= GET_FIELD (insn, 22, 26);
 		    (*info->fprintf_func) (info->stream, "%d", 63 - num);
 		    break;
 		  }
 		case 'P':
 		  (*info->fprintf_func) (info->stream, "%d",
 					 GET_FIELD (insn, 22, 26));
 		  break;
 		case 'q':
 		  {
 		    int num;
 		    num = GET_FIELD (insn, 20, 20) << 5;
 		    num |= GET_FIELD (insn, 22, 26);
 		    (*info->fprintf_func) (info->stream, "%d", num);
 		    break;
 		  }
 		case 'T':
 		  (*info->fprintf_func) (info->stream, "%d",
 					 32 - GET_FIELD (insn, 27, 31));
 		  break;
 		case '%':
 		  {
 		    int num;
 		    num = (GET_FIELD (insn, 23, 23) + 1) * 32;
 		    num -= GET_FIELD (insn, 27, 31);
 		    (*info->fprintf_func) (info->stream, "%d", num);
 		    break;
 		  }
 		case '|':
 		  {
 		    int num;
 		    num = (GET_FIELD (insn, 19, 19) + 1) * 32;
 		    num -= GET_FIELD (insn, 27, 31);
 		    (*info->fprintf_func) (info->stream, "%d", num);
 		    break;
 		  }
 		case '$':
 		  fput_const (GET_FIELD (insn, 20, 28), info);
 		  break;
 		case 'A':
 		  fput_const (GET_FIELD (insn, 6, 18), info);
 		  break;
 		case 'D':
 		  fput_const (GET_FIELD (insn, 6, 31), info);
 		  break;
 		case 'v':
 		  (*info->fprintf_func) (info->stream, ",%d",
 					 GET_FIELD (insn, 23, 25));
 		  break;
 		case 'O':
 		  fput_const ((GET_FIELD (insn, 6,20) << 5 |
 			       GET_FIELD (insn, 27, 31)), info);
 		  break;
 		case 'o':
 		  fput_const (GET_FIELD (insn, 6, 20), info);
 		  break;
 		case '2':
 		  fput_const ((GET_FIELD (insn, 6, 22) << 5 |
 			       GET_FIELD (insn, 27, 31)), info);
 		  break;
 		case '1':
 		  fput_const ((GET_FIELD (insn, 11, 20) << 5 |
 			       GET_FIELD (insn, 27, 31)), info);
 		  break;
 		case '0':
 		  fput_const ((GET_FIELD (insn, 16, 20) << 5 |
 			       GET_FIELD (insn, 27, 31)), info);
 		  break;
 		case 'u':
 		  (*info->fprintf_func) (info->stream, ",%d",
 					 GET_FIELD (insn, 23, 25));
 		  break;
 		case 'F':
 		  /* If no destination completer and not before a completer
 		     for fcmp, need a space here.  */
 		  if (s[1] == 'G' || s[1] == '?')
 		    fputs_filtered
 		      (float_format_names[GET_FIELD (insn, 19, 20)], info);
 		  else
 		    (*info->fprintf_func)
 		      (info->stream, "%s ",
 		       float_format_names[GET_FIELD (insn, 19, 20)]);
 		  break;
 		case 'G':
 		  (*info->fprintf_func)
 		    (info->stream, "%s ",
 		     float_format_names[GET_FIELD (insn, 17, 18)]);
 		  break;
 		case 'H':
 		  if (GET_FIELD (insn, 26, 26) == 1)
 		    (*info->fprintf_func) (info->stream, "%s ",
 					   float_format_names[0]);
 		  else
 		    (*info->fprintf_func) (info->stream, "%s ",
 					   float_format_names[1]);
 		  break;
 		case 'I':
 		  /* If no destination completer and not before a completer
 		     for fcmp, need a space here.  */
 		  if (s[1] == '?')
 		    fputs_filtered
 		      (float_format_names[GET_FIELD (insn, 20, 20)], info);
 		  else
 		    (*info->fprintf_func)
 		      (info->stream, "%s ",
 		       float_format_names[GET_FIELD (insn, 20, 20)]);
 		  break;
 
 		case 'J':
 		  fput_const (extract_14 (insn), info);
 		  break;
 
 		case '#':
 		  {
 		    int sign = GET_FIELD (insn, 31, 31);
 		    int imm10 = GET_FIELD (insn, 18, 27);
 		    int disp;
 
 		    if (sign)
 		      disp = (-1 << 10) | imm10;
 		    else
 		      disp = imm10;
 
 		    disp <<= 3;
 		    fput_const (disp, info);
 		    break;
 		  }
 		case 'K':
 		case 'd':
 		  {
 		    int sign = GET_FIELD (insn, 31, 31);
 		    int imm11 = GET_FIELD (insn, 18, 28);
 		    int disp;
 
 		    if (sign)
 		      disp = (-1 << 11) | imm11;
 		    else
 		      disp = imm11;
 
 		    disp <<= 2;
 		    fput_const (disp, info);
 		    break;
 		  }
 
 		case '>':
 		case 'y':
 		  {
 		    /* 16-bit long disp., PA2.0 wide only.  */
 		    int disp = extract_16 (insn);
 		    disp &= ~3;
 		    fput_const (disp, info);
 		    break;
 		  }
 
 		case '&':
 		  {
 		    /* 16-bit long disp., PA2.0 wide only.  */
 		    int disp = extract_16 (insn);
 		    disp &= ~7;
 		    fput_const (disp, info);
 		    break;
 		  }
 
 		case '_':
 		  break; /* Dealt with by '{' */
 
 		case '{':
 		  {
 		    int sub = GET_FIELD (insn, 14, 16);
 		    int df = GET_FIELD (insn, 17, 18);
 		    int sf = GET_FIELD (insn, 19, 20);
 		    const char * const * source = float_format_names;
 		    const char * const * dest = float_format_names;
 		    const char *t = "";
 
 		    if (sub == 4)
 		      {
 			fputs_filtered (",UND ", info);
 			break;
 		      }
 		    if ((sub & 3) == 3)
 		      t = ",t";
 		    if ((sub & 3) == 1)
 		      source = sub & 4 ? fcnv_ufixed_names : fcnv_fixed_names;
 		    if (sub & 2)
 		      dest = sub & 4 ? fcnv_ufixed_names : fcnv_fixed_names;
 
 		    (*info->fprintf_func) (info->stream, "%s%s%s ",
 					   t, source[sf], dest[df]);
 		    break;
 		  }
 
 		case 'm':
 		  {
 		    int y = GET_FIELD (insn, 16, 18);
 
 		    if (y != 1)
 		      fput_const ((y ^ 1) - 1, info);
 		  }
 		  break;
 
 		case 'h':
 		  {
 		    int cbit;
 
 		    cbit = GET_FIELD (insn, 16, 18);
 
 		    if (cbit > 0)
 		      (*info->fprintf_func) (info->stream, ",%d", cbit - 1);
 		    break;
 		  }
 
 		case '=':
 		  {
 		    int cond = GET_FIELD (insn, 27, 31);
 
 		    switch (cond)
 		      {
 		      case  0: fputs_filtered (" ", info); break;
 		      case  1: fputs_filtered ("acc ", info); break;
 		      case  2: fputs_filtered ("rej ", info); break;
 		      case  5: fputs_filtered ("acc8 ", info); break;
 		      case  6: fputs_filtered ("rej8 ", info); break;
 		      case  9: fputs_filtered ("acc6 ", info); break;
 		      case 13: fputs_filtered ("acc4 ", info); break;
 		      case 17: fputs_filtered ("acc2 ", info); break;
 		      default: break;
 		      }
 		    break;
 		  }
 
 		case 'X':
 		  (*info->print_address_func)
 		    (memaddr + 8 + extract_22 (insn), info);
 		  break;
 		case 'L':
 		  fputs_filtered (",rp", info);
 		  break;
 		default:
 		  (*info->fprintf_func) (info->stream, "%c", *s);
 		  break;
 		}
 	    }
 	  return sizeof (insn);
 	}
     }
   (*info->fprintf_func) (info->stream, "#%8x", insn);
   return sizeof (insn);
 }
diff --git a/disas/m68k.c b/disas/m68k.c
index 1f16e295ab..a755951bb7 100644
--- a/disas/m68k.c
+++ b/disas/m68k.c
@@ -1087,634 +1087,634 @@ static int
 print_insn_arg (const char *d,
 		unsigned char *buffer,
 		unsigned char *p0,
 		bfd_vma addr,
 		disassemble_info *info)
 {
   int val = 0;
   int place = d[1];
   unsigned char *p = p0;
   int regno;
   const char *regname;
   unsigned char *p1;
   double flval;
   int flt_p;
   bfd_signed_vma disp;
   unsigned int uval;
 
   switch (*d)
     {
     case 'c':		/* Cache identifier.  */
       {
         static const char *const cacheFieldName[] = { "nc", "dc", "ic", "bc" };
         val = fetch_arg (buffer, place, 2, info);
         (*info->fprintf_func) (info->stream, "%s", cacheFieldName[val]);
         break;
       }
 
     case 'a':		/* Address register indirect only. Cf. case '+'.  */
       {
         (*info->fprintf_func)
 	  (info->stream,
 	   "%s@",
 	   reg_names[fetch_arg (buffer, place, 3, info) + 8]);
         break;
       }
 
     case '_':		/* 32-bit absolute address for move16.  */
       {
         uval = NEXTULONG (p);
 	(*info->print_address_func) (uval, info);
         break;
       }
 
     case 'C':
       (*info->fprintf_func) (info->stream, "%%ccr");
       break;
 
     case 'S':
       (*info->fprintf_func) (info->stream, "%%sr");
       break;
 
     case 'U':
       (*info->fprintf_func) (info->stream, "%%usp");
       break;
 
     case 'E':
       (*info->fprintf_func) (info->stream, "%%acc");
       break;
 
     case 'G':
       (*info->fprintf_func) (info->stream, "%%macsr");
       break;
 
     case 'H':
       (*info->fprintf_func) (info->stream, "%%mask");
       break;
 
     case 'J':
       {
 	/* FIXME: There's a problem here, different m68k processors call the
 	   same address different names. This table can't get it right
 	   because it doesn't know which processor it's disassembling for.  */
 	static const struct { const char *name; int value; } names[]
 	  = {{"%sfc", 0x000}, {"%dfc", 0x001}, {"%cacr", 0x002},
 	     {"%tc",  0x003}, {"%itt0",0x004}, {"%itt1", 0x005},
              {"%dtt0",0x006}, {"%dtt1",0x007}, {"%buscr",0x008},
 	     {"%usp", 0x800}, {"%vbr", 0x801}, {"%caar", 0x802},
 	     {"%msp", 0x803}, {"%isp", 0x804},
 	     {"%flashbar", 0xc04}, {"%rambar", 0xc05}, /* mcf528x added these.  */
 
 	     /* Should we be calling this psr like we do in case 'Y'?  */
 	     {"%mmusr",0x805},
 
              {"%urp", 0x806}, {"%srp", 0x807}, {"%pcr", 0x808}};
 
 	val = fetch_arg (buffer, place, 12, info);
 	for (regno = sizeof names / sizeof names[0] - 1; regno >= 0; regno--)
 	  if (names[regno].value == val)
 	    {
 	      (*info->fprintf_func) (info->stream, "%s", names[regno].name);
 	      break;
 	    }
 	if (regno < 0)
 	  (*info->fprintf_func) (info->stream, "%d", val);
       }
       break;
 
     case 'Q':
       val = fetch_arg (buffer, place, 3, info);
       /* 0 means 8, except for the bkpt instruction... */
       if (val == 0 && d[1] != 's')
 	val = 8;
       (*info->fprintf_func) (info->stream, "#%d", val);
       break;
 
     case 'x':
       val = fetch_arg (buffer, place, 3, info);
       /* 0 means -1.  */
       if (val == 0)
 	val = -1;
       (*info->fprintf_func) (info->stream, "#%d", val);
       break;
 
     case 'M':
       if (place == 'h')
 	{
 	  static const char *const scalefactor_name[] = { "<<", ">>" };
 	  val = fetch_arg (buffer, place, 1, info);
 	  (*info->fprintf_func) (info->stream, "%s", scalefactor_name[val]);
 	}
       else
 	{
 	  val = fetch_arg (buffer, place, 8, info);
 	  if (val & 0x80)
 	    val = val - 0x100;
 	  (*info->fprintf_func) (info->stream, "#%d", val);
 	}
       break;
 
     case 'T':
       val = fetch_arg (buffer, place, 4, info);
       (*info->fprintf_func) (info->stream, "#%d", val);
       break;
 
     case 'D':
       (*info->fprintf_func) (info->stream, "%s",
 			     reg_names[fetch_arg (buffer, place, 3, info)]);
       break;
 
     case 'A':
       (*info->fprintf_func)
 	(info->stream, "%s",
 	 reg_names[fetch_arg (buffer, place, 3, info) + 010]);
       break;
 
     case 'R':
       (*info->fprintf_func)
 	(info->stream, "%s",
 	 reg_names[fetch_arg (buffer, place, 4, info)]);
       break;
 
     case 'r':
       regno = fetch_arg (buffer, place, 4, info);
       if (regno > 7)
 	(*info->fprintf_func) (info->stream, "%s@", reg_names[regno]);
       else
 	(*info->fprintf_func) (info->stream, "@(%s)", reg_names[regno]);
       break;
 
     case 'F':
       (*info->fprintf_func)
 	(info->stream, "%%fp%d",
 	 fetch_arg (buffer, place, 3, info));
       break;
 
     case 'O':
       val = fetch_arg (buffer, place, 6, info);
       if (val & 0x20)
 	(*info->fprintf_func) (info->stream, "%s", reg_names[val & 7]);
       else
 	(*info->fprintf_func) (info->stream, "%d", val);
       break;
 
     case '+':
       (*info->fprintf_func)
 	(info->stream, "%s@+",
 	 reg_names[fetch_arg (buffer, place, 3, info) + 8]);
       break;
 
     case '-':
       (*info->fprintf_func)
 	(info->stream, "%s@-",
 	 reg_names[fetch_arg (buffer, place, 3, info) + 8]);
       break;
 
     case 'k':
       if (place == 'k')
 	(*info->fprintf_func)
 	  (info->stream, "{%s}",
 	   reg_names[fetch_arg (buffer, place, 3, info)]);
       else if (place == 'C')
 	{
 	  val = fetch_arg (buffer, place, 7, info);
 	  if (val > 63)		/* This is a signed constant.  */
 	    val -= 128;
 	  (*info->fprintf_func) (info->stream, "{#%d}", val);
 	}
       else
 	return -2;
       break;
 
     case '#':
     case '^':
       p1 = buffer + (*d == '#' ? 2 : 4);
       if (place == 's')
 	val = fetch_arg (buffer, place, 4, info);
       else if (place == 'C')
 	val = fetch_arg (buffer, place, 7, info);
       else if (place == '8')
 	val = fetch_arg (buffer, place, 3, info);
       else if (place == '3')
 	val = fetch_arg (buffer, place, 8, info);
       else if (place == 'b')
 	val = NEXTBYTE (p1);
       else if (place == 'w' || place == 'W')
 	val = NEXTWORD (p1);
       else if (place == 'l')
 	val = NEXTLONG (p1);
       else
 	return -2;
       (*info->fprintf_func) (info->stream, "#%d", val);
       break;
 
     case 'B':
       if (place == 'b')
 	disp = NEXTBYTE (p);
       else if (place == 'B')
 	disp = COERCE_SIGNED_CHAR (buffer[1]);
       else if (place == 'w' || place == 'W')
 	disp = NEXTWORD (p);
       else if (place == 'l' || place == 'L' || place == 'C')
 	disp = NEXTLONG (p);
       else if (place == 'g')
 	{
 	  disp = NEXTBYTE (buffer);
 	  if (disp == 0)
 	    disp = NEXTWORD (p);
 	  else if (disp == -1)
 	    disp = NEXTLONG (p);
 	}
       else if (place == 'c')
 	{
 	  if (buffer[1] & 0x40)		/* If bit six is one, long offset.  */
 	    disp = NEXTLONG (p);
 	  else
 	    disp = NEXTWORD (p);
 	}
       else
 	return -2;
 
       (*info->print_address_func) (addr + disp, info);
       break;
 
     case 'd':
       val = NEXTWORD (p);
       (*info->fprintf_func)
 	(info->stream, "%s@(%d)",
 	 reg_names[fetch_arg (buffer, place, 3, info) + 8], val);
       break;
 
     case 's':
       (*info->fprintf_func) (info->stream, "%s",
 			     fpcr_names[fetch_arg (buffer, place, 3, info)]);
       break;
 
     case 'e':
       val = fetch_arg(buffer, place, 2, info);
       (*info->fprintf_func) (info->stream, "%%acc%d", val);
       break;
 
     case 'g':
       val = fetch_arg(buffer, place, 1, info);
       (*info->fprintf_func) (info->stream, "%%accext%s", val==0 ? "01" : "23");
       break;
 
     case 'i':
       val = fetch_arg(buffer, place, 2, info);
       if (val == 1)
 	(*info->fprintf_func) (info->stream, "<<");
       else if (val == 3)
 	(*info->fprintf_func) (info->stream, ">>");
       else
 	return -1;
       break;
 
     case 'I':
       /* Get coprocessor ID... */
       val = fetch_arg (buffer, 'd', 3, info);
 
       if (val != 1)				/* Unusual coprocessor ID?  */
 	(*info->fprintf_func) (info->stream, "(cpid=%d) ", val);
       break;
 
     case '4':
     case '*':
     case '~':
     case '%':
     case ';':
     case '@':
     case '!':
     case '$':
     case '?':
     case '/':
     case '&':
     case '|':
     case '<':
     case '>':
     case 'm':
     case 'n':
     case 'o':
     case 'p':
     case 'q':
     case 'v':
     case 'b':
     case 'w':
     case 'y':
     case 'z':
       if (place == 'd')
 	{
 	  val = fetch_arg (buffer, 'x', 6, info);
 	  val = ((val & 7) << 3) + ((val >> 3) & 7);
 	}
       else
 	val = fetch_arg (buffer, 's', 6, info);
 
       /* If the <ea> is invalid for *d, then reject this match.  */
       if (!m68k_valid_ea (*d, val))
 	return -1;
 
       /* Get register number assuming address register.  */
       regno = (val & 7) + 8;
       regname = reg_names[regno];
       switch (val >> 3)
 	{
 	case 0:
 	  (*info->fprintf_func) (info->stream, "%s", reg_names[val]);
 	  break;
 
 	case 1:
 	  (*info->fprintf_func) (info->stream, "%s", regname);
 	  break;
 
 	case 2:
 	  (*info->fprintf_func) (info->stream, "%s@", regname);
 	  break;
 
 	case 3:
 	  (*info->fprintf_func) (info->stream, "%s@+", regname);
 	  break;
 
 	case 4:
 	  (*info->fprintf_func) (info->stream, "%s@-", regname);
 	  break;
 
 	case 5:
 	  val = NEXTWORD (p);
 	  (*info->fprintf_func) (info->stream, "%s@(%d)", regname, val);
 	  break;
 
 	case 6:
 	  p = print_indexed (regno, p, addr, info);
 	  break;
 
 	case 7:
 	  switch (val & 7)
 	    {
 	    case 0:
 	      val = NEXTWORD (p);
 	      (*info->print_address_func) (val, info);
 	      break;
 
 	    case 1:
 	      uval = NEXTULONG (p);
 	      (*info->print_address_func) (uval, info);
 	      break;
 
 	    case 2:
 	      val = NEXTWORD (p);
 	      (*info->fprintf_func) (info->stream, "%%pc@(");
 	      (*info->print_address_func) (addr + val, info);
 	      (*info->fprintf_func) (info->stream, ")");
 	      break;
 
 	    case 3:
 	      p = print_indexed (-1, p, addr, info);
 	      break;
 
 	    case 4:
 	      flt_p = 1;	/* Assume it's a float... */
 	      switch (place)
 	      {
 		case 'b':
 		  val = NEXTBYTE (p);
 		  flt_p = 0;
 		  break;
 
 		case 'w':
 		  val = NEXTWORD (p);
 		  flt_p = 0;
 		  break;
 
 		case 'l':
 		  val = NEXTLONG (p);
 		  flt_p = 0;
 		  break;
 
 		case 'f':
 		  NEXTSINGLE (flval, p);
 		  break;
 
 		case 'F':
 		  NEXTDOUBLE (flval, p);
 		  break;
 
 		case 'x':
 		  NEXTEXTEND (flval, p);
 		  break;
 
 		case 'p':
 		  flval = NEXTPACKED (p);
 		  break;
 
 		default:
 		  return -1;
 	      }
 	      if (flt_p)	/* Print a float? */
 		(*info->fprintf_func) (info->stream, "#%g", flval);
 	      else
 		(*info->fprintf_func) (info->stream, "#%d", val);
 	      break;
 
 	    default:
 	      return -1;
 	    }
 	}
 
       /* If place is '/', then this is the case of the mask bit for
 	 mac/emac loads. Now that the arg has been printed, grab the
 	 mask bit and if set, add a '&' to the arg.  */
       if (place == '/')
 	{
 	  val = fetch_arg (buffer, place, 1, info);
 	  if (val)
 	    info->fprintf_func (info->stream, "&");
 	}
       break;
 
     case 'L':
     case 'l':
 	if (place == 'w')
 	  {
 	    char doneany;
 	    p1 = buffer + 2;
 	    val = NEXTWORD (p1);
 	    /* Move the pointer ahead if this point is farther ahead
 	       than the last.  */
 	    p = p1 > p ? p1 : p;
 	    if (val == 0)
 	      {
 		(*info->fprintf_func) (info->stream, "#0");
 		break;
 	      }
 	    if (*d == 'l')
 	      {
 		int newval = 0;
 
 		for (regno = 0; regno < 16; ++regno)
 		  if (val & (0x8000 >> regno))
 		    newval |= 1 << regno;
 		val = newval;
 	      }
 	    val &= 0xffff;
 	    doneany = 0;
 	    for (regno = 0; regno < 16; ++regno)
 	      if (val & (1 << regno))
 		{
 		  int first_regno;
 
 		  if (doneany)
 		    (*info->fprintf_func) (info->stream, "/");
 		  doneany = 1;
 		  (*info->fprintf_func) (info->stream, "%s", reg_names[regno]);
 		  first_regno = regno;
 		  while (val & (1 << (regno + 1)))
 		    ++regno;
 		  if (regno > first_regno)
 		    (*info->fprintf_func) (info->stream, "-%s",
 					   reg_names[regno]);
 		}
 	  }
 	else if (place == '3')
 	  {
 	    /* `fmovem' insn.  */
 	    char doneany;
 	    val = fetch_arg (buffer, place, 8, info);
 	    if (val == 0)
 	      {
 		(*info->fprintf_func) (info->stream, "#0");
 		break;
 	      }
 	    if (*d == 'l')
 	      {
 		int newval = 0;
 
 		for (regno = 0; regno < 8; ++regno)
 		  if (val & (0x80 >> regno))
 		    newval |= 1 << regno;
 		val = newval;
 	      }
 	    val &= 0xff;
 	    doneany = 0;
 	    for (regno = 0; regno < 8; ++regno)
 	      if (val & (1 << regno))
 		{
 		  int first_regno;
 		  if (doneany)
 		    (*info->fprintf_func) (info->stream, "/");
 		  doneany = 1;
 		  (*info->fprintf_func) (info->stream, "%%fp%d", regno);
 		  first_regno = regno;
 		  while (val & (1 << (regno + 1)))
 		    ++regno;
 		  if (regno > first_regno)
 		    (*info->fprintf_func) (info->stream, "-%%fp%d", regno);
 		}
 	  }
 	else if (place == '8')
 	  {
 	    /* fmoveml for FP status registers.  */
 	    (*info->fprintf_func) (info->stream, "%s",
 				   fpcr_names[fetch_arg (buffer, place, 3,
 							 info)]);
 	  }
 	else
 	  return -2;
       break;
 
     case 'X':
       place = '8';
-      /* fall through */
+      fallthrough;
     case 'Y':
     case 'Z':
     case 'W':
     case '0':
     case '1':
     case '2':
     case '3':
       {
 	int reg = fetch_arg (buffer, place, 5, info);
         const char *name = 0;
 
 	switch (reg)
 	  {
 	  case 2: name = "%tt0"; break;
 	  case 3: name = "%tt1"; break;
 	  case 0x10: name = "%tc"; break;
 	  case 0x11: name = "%drp"; break;
 	  case 0x12: name = "%srp"; break;
 	  case 0x13: name = "%crp"; break;
 	  case 0x14: name = "%cal"; break;
 	  case 0x15: name = "%val"; break;
 	  case 0x16: name = "%scc"; break;
 	  case 0x17: name = "%ac"; break;
 	  case 0x18: name = "%psr"; break;
 	  case 0x19: name = "%pcsr"; break;
 	  case 0x1c:
 	  case 0x1d:
 	    {
 	      int break_reg = ((buffer[3] >> 2) & 7);
 
 	      (*info->fprintf_func)
 		(info->stream, reg == 0x1c ? "%%bad%d" : "%%bac%d",
 		 break_reg);
 	    }
 	    break;
 	  default:
 	    (*info->fprintf_func) (info->stream, "<mmu register %d>", reg);
 	  }
 	if (name)
 	  (*info->fprintf_func) (info->stream, "%s", name);
       }
       break;
 
     case 'f':
       {
 	int fc = fetch_arg (buffer, place, 5, info);
 
 	if (fc == 1)
 	  (*info->fprintf_func) (info->stream, "%%dfc");
 	else if (fc == 0)
 	  (*info->fprintf_func) (info->stream, "%%sfc");
 	else
 	  /* xgettext:c-format */
 	  (*info->fprintf_func) (info->stream, "<function code %d>", fc);
       }
       break;
 
     case 'V':
       (*info->fprintf_func) (info->stream, "%%val");
       break;
 
     case 't':
       {
 	int level = fetch_arg (buffer, place, 3, info);
 
 	(*info->fprintf_func) (info->stream, "%d", level);
       }
       break;
 
     case 'u':
       {
 	short is_upper = 0;
 	int reg = fetch_arg (buffer, place, 5, info);
 
 	if (reg & 0x10)
 	  {
 	    is_upper = 1;
 	    reg &= 0xf;
 	  }
 	(*info->fprintf_func) (info->stream, "%s%s",
 			       reg_half_names[reg],
 			       is_upper ? "u" : "l");
       }
       break;
 
     default:
       return -2;
     }
 
   return p - p0;
 }
 
 /* Try to match the current instruction to best and if so, return the
    number of bytes consumed from the instruction stream, else zero.  */
diff --git a/disas/sh4.c b/disas/sh4.c
index dcdbdf26d8..3c51fd707d 100644
--- a/disas/sh4.c
+++ b/disas/sh4.c
@@ -1509,565 +1509,567 @@ int
 print_insn_sh (bfd_vma memaddr, struct disassemble_info *info)
 {
   fprintf_function fprintf_fn = info->fprintf_func;
   void *stream = info->stream;
   unsigned char insn[4];
   unsigned char nibs[8];
   int status;
   bfd_vma relmask = ~(bfd_vma) 0;
   const sh_opcode_info *op;
   unsigned int target_arch;
   int allow_op32;
 
   switch (info->mach)
     {
     case bfd_mach_sh:
       target_arch = arch_sh1;
       break;
     case bfd_mach_sh4:
       target_arch = arch_sh4;
       break;
     case bfd_mach_sh5:
 #ifdef INCLUDE_SHMEDIA
       status = print_insn_sh64 (memaddr, info);
       if (status != -2)
 	return status;
 #endif
       /* When we get here for sh64, it's because we want to disassemble
 	 SHcompact, i.e. arch_sh4.  */
       target_arch = arch_sh4;
       break;
     default:
       fprintf (stderr, "sh architecture not supported\n");
       return -1;
     }
 
   status = info->read_memory_func (memaddr, insn, 2, info);
 
   if (status != 0)
     {
       info->memory_error_func (status, memaddr, info);
       return -1;
     }
 
   if (info->endian == BFD_ENDIAN_LITTLE)
     {
       nibs[0] = (insn[1] >> 4) & 0xf;
       nibs[1] = insn[1] & 0xf;
 
       nibs[2] = (insn[0] >> 4) & 0xf;
       nibs[3] = insn[0] & 0xf;
     }
   else
     {
       nibs[0] = (insn[0] >> 4) & 0xf;
       nibs[1] = insn[0] & 0xf;
 
       nibs[2] = (insn[1] >> 4) & 0xf;
       nibs[3] = insn[1] & 0xf;
     }
   status = info->read_memory_func (memaddr + 2, insn + 2, 2, info);
   if (status != 0)
     allow_op32 = 0;
   else
     {
       allow_op32 = 1;
 
       if (info->endian == BFD_ENDIAN_LITTLE)
 	{
 	  nibs[4] = (insn[3] >> 4) & 0xf;
 	  nibs[5] = insn[3] & 0xf;
 
 	  nibs[6] = (insn[2] >> 4) & 0xf;
 	  nibs[7] = insn[2] & 0xf;
 	}
       else
 	{
 	  nibs[4] = (insn[2] >> 4) & 0xf;
 	  nibs[5] = insn[2] & 0xf;
 
 	  nibs[6] = (insn[3] >> 4) & 0xf;
 	  nibs[7] = insn[3] & 0xf;
 	}
     }
 
   if (nibs[0] == 0xf && (nibs[1] & 4) == 0
       && SH_MERGE_ARCH_SET_VALID (target_arch, arch_sh_dsp_up))
     {
       if (nibs[1] & 8)
 	{
 	  int field_b;
 
 	  status = info->read_memory_func (memaddr + 2, insn, 2, info);
 
 	  if (status != 0)
 	    {
 	      info->memory_error_func (status, memaddr + 2, info);
 	      return -1;
 	    }
 
 	  if (info->endian == BFD_ENDIAN_LITTLE)
 	    field_b = insn[1] << 8 | insn[0];
 	  else
 	    field_b = insn[0] << 8 | insn[1];
 
 	  print_insn_ppi (field_b, info);
 	  print_insn_ddt ((nibs[1] << 8) | (nibs[2] << 4) | nibs[3], info);
 	  return 4;
 	}
       print_insn_ddt ((nibs[1] << 8) | (nibs[2] << 4) | nibs[3], info);
       return 2;
     }
   for (op = sh_table; op->name; op++)
     {
       int n;
       int imm = 0;
       int rn = 0;
       int rm = 0;
       int rb = 0;
       int disp_pc;
       bfd_vma disp_pc_addr = 0;
       int disp = 0;
       int has_disp = 0;
       int max_n = SH_MERGE_ARCH_SET (op->arch, arch_op32) ? 8 : 4;
 
       if (!allow_op32
 	  && SH_MERGE_ARCH_SET (op->arch, arch_op32))
 	goto fail;
 
       if (!SH_MERGE_ARCH_SET_VALID (op->arch, target_arch))
 	goto fail;
       for (n = 0; n < max_n; n++)
 	{
 	  int i = op->nibbles[n];
 
 	  if (i < 16)
 	    {
 	      if (nibs[n] == i)
 		continue;
 	      goto fail;
 	    }
 	  switch (i)
 	    {
 	    case BRANCH_8:
 	      imm = (nibs[2] << 4) | (nibs[3]);
 	      if (imm & 0x80)
 		imm |= ~0xff;
 	      imm = ((char) imm) * 2 + 4;
 	      goto ok;
 	    case BRANCH_12:
 	      imm = ((nibs[1]) << 8) | (nibs[2] << 4) | (nibs[3]);
 	      if (imm & 0x800)
 		imm |= ~0xfff;
 	      imm = imm * 2 + 4;
 	      goto ok;
 	    case IMM0_3c:
 	      if (nibs[3] & 0x8)
 		goto fail;
 	      imm = nibs[3] & 0x7;
 	      break;
 	    case IMM0_3s:
 	      if (!(nibs[3] & 0x8))
 		goto fail;
 	      imm = nibs[3] & 0x7;
 	      break;
 	    case IMM0_3Uc:
 	      if (nibs[2] & 0x8)
 		goto fail;
 	      imm = nibs[2] & 0x7;
 	      break;
 	    case IMM0_3Us:
 	      if (!(nibs[2] & 0x8))
 		goto fail;
 	      imm = nibs[2] & 0x7;
 	      break;
 	    case DISP0_12:
 	    case DISP1_12:
 	      disp = (nibs[5] << 8) | (nibs[6] << 4) | nibs[7];
 	      has_disp = 1;
 	      goto ok;
 	    case DISP0_12BY2:
 	    case DISP1_12BY2:
 	      disp = ((nibs[5] << 8) | (nibs[6] << 4) | nibs[7]) << 1;
 	      relmask = ~(bfd_vma) 1;
 	      has_disp = 1;
 	      goto ok;
 	    case DISP0_12BY4:
 	    case DISP1_12BY4:
 	      disp = ((nibs[5] << 8) | (nibs[6] << 4) | nibs[7]) << 2;
 	      relmask = ~(bfd_vma) 3;
 	      has_disp = 1;
 	      goto ok;
 	    case DISP0_12BY8:
 	    case DISP1_12BY8:
 	      disp = ((nibs[5] << 8) | (nibs[6] << 4) | nibs[7]) << 3;
 	      relmask = ~(bfd_vma) 7;
 	      has_disp = 1;
 	      goto ok;
 	    case IMM0_20_4:
 	      break;
 	    case IMM0_20:
 	      imm = ((nibs[2] << 16) | (nibs[4] << 12) | (nibs[5] << 8)
 		     | (nibs[6] << 4) | nibs[7]);
 	      if (imm & 0x80000)
 		imm -= 0x100000;
 	      goto ok;
 	    case IMM0_20BY8:
 	      imm = ((nibs[2] << 16) | (nibs[4] << 12) | (nibs[5] << 8)
 		     | (nibs[6] << 4) | nibs[7]);
 	      imm <<= 8;
 	      if (imm & 0x8000000)
 		imm -= 0x10000000;
 	      goto ok;
 	    case IMM0_4:
 	    case IMM1_4:
 	      imm = nibs[3];
 	      goto ok;
 	    case IMM0_4BY2:
 	    case IMM1_4BY2:
 	      imm = nibs[3] << 1;
 	      goto ok;
 	    case IMM0_4BY4:
 	    case IMM1_4BY4:
 	      imm = nibs[3] << 2;
 	      goto ok;
 	    case IMM0_8:
 	    case IMM1_8:
 	      imm = (nibs[2] << 4) | nibs[3];
 	      disp = imm;
 	      has_disp = 1;
 	      if (imm & 0x80)
 		imm -= 0x100;
 	      goto ok;
 	    case PCRELIMM_8BY2:
 	      imm = ((nibs[2] << 4) | nibs[3]) << 1;
 	      relmask = ~(bfd_vma) 1;
 	      goto ok;
 	    case PCRELIMM_8BY4:
 	      imm = ((nibs[2] << 4) | nibs[3]) << 2;
 	      relmask = ~(bfd_vma) 3;
 	      goto ok;
 	    case IMM0_8BY2:
 	    case IMM1_8BY2:
 	      imm = ((nibs[2] << 4) | nibs[3]) << 1;
 	      goto ok;
 	    case IMM0_8BY4:
 	    case IMM1_8BY4:
 	      imm = ((nibs[2] << 4) | nibs[3]) << 2;
 	      goto ok;
 	    case REG_N_D:
 	      if ((nibs[n] & 1) != 0)
 		goto fail;
-	      /* fall through */
+        fallthrough;
 	    case REG_N:
 	      rn = nibs[n];
 	      break;
 	    case REG_M:
 	      rm = nibs[n];
 	      break;
 	    case REG_N_B01:
 	      if ((nibs[n] & 0x3) != 1 /* binary 01 */)
 		goto fail;
 	      rn = (nibs[n] & 0xc) >> 2;
 	      break;
 	    case REG_NM:
 	      rn = (nibs[n] & 0xc) >> 2;
 	      rm = (nibs[n] & 0x3);
 	      break;
 	    case REG_B:
 	      rb = nibs[n] & 0x07;
 	      break;
 	    case SDT_REG_N:
 	      /* sh-dsp: single data transfer.  */
 	      rn = nibs[n];
 	      if ((rn & 0xc) != 4)
 		goto fail;
 	      rn = rn & 0x3;
 	      rn |= (!(rn & 2)) << 2;
 	      break;
 	    case PPI:
 	    case REPEAT:
 	      goto fail;
 	    default:
 	      abort ();
 	    }
 	}
 
     ok:
       /* sh2a has D_REG but not X_REG.  We don't know the pattern
 	 doesn't match unless we check the output args to see if they
 	 make sense.  */
       if (target_arch == arch_sh2a
 	  && ((op->arg[0] == DX_REG_M && (rm & 1) != 0)
 	      || (op->arg[1] == DX_REG_N && (rn & 1) != 0)))
 	goto fail;
 
       fprintf_fn (stream, "%s\t", op->name);
       disp_pc = 0;
       for (n = 0; n < 3 && op->arg[n] != A_END; n++)
 	{
 	  if (n && op->arg[1] != A_END)
 	    fprintf_fn (stream, ",");
 	  switch (op->arg[n])
 	    {
 	    case A_IMM:
 	      fprintf_fn (stream, "#%d", imm);
 	      break;
 	    case A_R0:
 	      fprintf_fn (stream, "r0");
 	      break;
 	    case A_REG_N:
 	      fprintf_fn (stream, "r%d", rn);
 	      break;
 	    case A_INC_N:
 	    case AS_INC_N:
 	      fprintf_fn (stream, "@r%d+", rn);
 	      break;
 	    case A_DEC_N:
 	    case AS_DEC_N:
 	      fprintf_fn (stream, "@-r%d", rn);
 	      break;
 	    case A_IND_N:
 	    case AS_IND_N:
 	      fprintf_fn (stream, "@r%d", rn);
 	      break;
 	    case A_DISP_REG_N:
 	      fprintf_fn (stream, "@(%d,r%d)", has_disp?disp:imm, rn);
 	      break;
 	    case AS_PMOD_N:
 	      fprintf_fn (stream, "@r%d+r8", rn);
 	      break;
 	    case A_REG_M:
 	      fprintf_fn (stream, "r%d", rm);
 	      break;
 	    case A_INC_M:
 	      fprintf_fn (stream, "@r%d+", rm);
 	      break;
 	    case A_DEC_M:
 	      fprintf_fn (stream, "@-r%d", rm);
 	      break;
 	    case A_IND_M:
 	      fprintf_fn (stream, "@r%d", rm);
 	      break;
 	    case A_DISP_REG_M:
 	      fprintf_fn (stream, "@(%d,r%d)", has_disp?disp:imm, rm);
 	      break;
 	    case A_REG_B:
 	      fprintf_fn (stream, "r%d_bank", rb);
 	      break;
 	    case A_DISP_PC:
 	      disp_pc = 1;
 	      disp_pc_addr = imm + 4 + (memaddr & relmask);
 	      (*info->print_address_func) (disp_pc_addr, info);
 	      break;
 	    case A_IND_R0_REG_N:
 	      fprintf_fn (stream, "@(r0,r%d)", rn);
 	      break;
 	    case A_IND_R0_REG_M:
 	      fprintf_fn (stream, "@(r0,r%d)", rm);
 	      break;
 	    case A_DISP_GBR:
 	      fprintf_fn (stream, "@(%d,gbr)", has_disp?disp:imm);
 	      break;
 	    case A_TBR:
 	      fprintf_fn (stream, "tbr");
 	      break;
 	    case A_DISP2_TBR:
 	      fprintf_fn (stream, "@@(%d,tbr)", has_disp?disp:imm);
 	      break;
 	    case A_INC_R15:
 	      fprintf_fn (stream, "@r15+");
 	      break;
 	    case A_DEC_R15:
 	      fprintf_fn (stream, "@-r15");
 	      break;
 	    case A_R0_GBR:
 	      fprintf_fn (stream, "@(r0,gbr)");
 	      break;
 	    case A_BDISP12:
 	    case A_BDISP8:
                 {
                     bfd_vma addr;
                     addr = imm + memaddr;
                     (*info->print_address_func) (addr, info);
                 }
 	      break;
 	    case A_SR:
 	      fprintf_fn (stream, "sr");
 	      break;
 	    case A_GBR:
 	      fprintf_fn (stream, "gbr");
 	      break;
 	    case A_VBR:
 	      fprintf_fn (stream, "vbr");
 	      break;
 	    case A_DSR:
 	      fprintf_fn (stream, "dsr");
 	      break;
 	    case A_MOD:
 	      fprintf_fn (stream, "mod");
 	      break;
 	    case A_RE:
 	      fprintf_fn (stream, "re");
 	      break;
 	    case A_RS:
 	      fprintf_fn (stream, "rs");
 	      break;
 	    case A_A0:
 	      fprintf_fn (stream, "a0");
 	      break;
 	    case A_X0:
 	      fprintf_fn (stream, "x0");
 	      break;
 	    case A_X1:
 	      fprintf_fn (stream, "x1");
 	      break;
 	    case A_Y0:
 	      fprintf_fn (stream, "y0");
 	      break;
 	    case A_Y1:
 	      fprintf_fn (stream, "y1");
 	      break;
 	    case DSP_REG_M:
 	      print_dsp_reg (rm, fprintf_fn, stream);
 	      break;
 	    case A_SSR:
 	      fprintf_fn (stream, "ssr");
 	      break;
 	    case A_SPC:
 	      fprintf_fn (stream, "spc");
 	      break;
 	    case A_MACH:
 	      fprintf_fn (stream, "mach");
 	      break;
 	    case A_MACL:
 	      fprintf_fn (stream, "macl");
 	      break;
 	    case A_PR:
 	      fprintf_fn (stream, "pr");
 	      break;
 	    case A_SGR:
 	      fprintf_fn (stream, "sgr");
 	      break;
 	    case A_DBR:
 	      fprintf_fn (stream, "dbr");
 	      break;
 	    case F_REG_N:
 	      fprintf_fn (stream, "fr%d", rn);
 	      break;
 	    case F_REG_M:
 	      fprintf_fn (stream, "fr%d", rm);
 	      break;
 	    case DX_REG_N:
 	      if (rn & 1)
 		{
 		  fprintf_fn (stream, "xd%d", rn & ~1);
 		  break;
 		}
 	      /* fallthrough */
+        fallthrough;
 	    case D_REG_N:
 	      fprintf_fn (stream, "dr%d", rn);
 	      break;
 	    case DX_REG_M:
 	      if (rm & 1)
 		{
 		  fprintf_fn (stream, "xd%d", rm & ~1);
 		  break;
 		}
 	      /* fallthrough */
+        fallthrough;
 	    case D_REG_M:
 	      fprintf_fn (stream, "dr%d", rm);
 	      break;
 	    case FPSCR_M:
 	    case FPSCR_N:
 	      fprintf_fn (stream, "fpscr");
 	      break;
 	    case FPUL_M:
 	    case FPUL_N:
 	      fprintf_fn (stream, "fpul");
 	      break;
 	    case F_FR0:
 	      fprintf_fn (stream, "fr0");
 	      break;
 	    case V_REG_N:
 	      fprintf_fn (stream, "fv%d", rn * 4);
 	      break;
 	    case V_REG_M:
 	      fprintf_fn (stream, "fv%d", rm * 4);
 	      break;
 	    case XMTRX_M4:
 	      fprintf_fn (stream, "xmtrx");
 	      break;
 	    default:
 	      abort ();
 	    }
 	}
 
 #if 0
       /* This code prints instructions in delay slots on the same line
          as the instruction which needs the delay slots.  This can be
          confusing, since other disassembler don't work this way, and
          it means that the instructions are not all in a line.  So I
          disabled it.  Ian.  */
       if (!(info->flags & 1)
 	  && (op->name[0] == 'j'
 	      || (op->name[0] == 'b'
 		  && (op->name[1] == 'r'
 		      || op->name[1] == 's'))
 	      || (op->name[0] == 'r' && op->name[1] == 't')
 	      || (op->name[0] == 'b' && op->name[2] == '.')))
 	{
 	  info->flags |= 1;
 	  fprintf_fn (stream, "\t(slot ");
 	  print_insn_sh (memaddr + 2, info);
 	  info->flags &= ~1;
 	  fprintf_fn (stream, ")");
 	  return 4;
 	}
 #endif
 
       if (disp_pc && strcmp (op->name, "mova") != 0)
 	{
 	  int size;
 	  bfd_byte bytes[4];
 
 	  if (relmask == ~(bfd_vma) 1)
 	    size = 2;
 	  else
 	    size = 4;
 	  status = info->read_memory_func (disp_pc_addr, bytes, size, info);
 	  if (status == 0)
 	    {
 	      unsigned int val;
 
 	      if (size == 2)
 		{
 		  if (info->endian == BFD_ENDIAN_LITTLE)
 		    val = bfd_getl16 (bytes);
 		  else
 		    val = bfd_getb16 (bytes);
 		}
 	      else
 		{
 		  if (info->endian == BFD_ENDIAN_LITTLE)
 		    val = bfd_getl32 (bytes);
 		  else
 		    val = bfd_getb32 (bytes);
 		}
 	      if ((*info->symbol_at_address_func) (val, info))
 		{
 		  fprintf_fn (stream, "\t! ");
 		  (*info->print_address_func) (val, info);
 		}
 	      else
 		fprintf_fn (stream, "\t! 0x%x", val);
 	    }
 	}
 
       return SH_MERGE_ARCH_SET (op->arch, arch_op32) ? 4 : 2;
     fail:
       ;
 
     }
   fprintf_fn (stream, ".word 0x%x%x%x%x", nibs[0], nibs[1], nibs[2], nibs[3]);
   return 2;
 }
diff --git a/disas/sparc.c b/disas/sparc.c
index 5689533ce1..61139256b0 100644
--- a/disas/sparc.c
+++ b/disas/sparc.c
@@ -2667,570 +2667,570 @@ int
 print_insn_sparc (bfd_vma memaddr, disassemble_info *info)
 {
   FILE *stream = info->stream;
   bfd_byte buffer[4];
   unsigned long insn;
   sparc_opcode_hash *op;
   /* Nonzero of opcode table has been initialized.  */
   static int opcodes_initialized = 0;
   /* bfd mach number of last call.  */
   static unsigned long current_mach = 0;
   bfd_vma (*getword) (const unsigned char *);
 
   if (!opcodes_initialized
       || info->mach != current_mach)
     {
       int i;
 
       current_arch_mask = compute_arch_mask (info->mach);
 
       if (!opcodes_initialized)
         sorted_opcodes =
           malloc (sparc_num_opcodes * sizeof (sparc_opcode *));
       /* Reset the sorted table so we can resort it.  */
       for (i = 0; i < sparc_num_opcodes; ++i)
         sorted_opcodes[i] = &sparc_opcodes[i];
       qsort ((char *) sorted_opcodes, sparc_num_opcodes,
              sizeof (sorted_opcodes[0]), compare_opcodes);
 
       build_hash_table (sorted_opcodes, opcode_hash_table, sparc_num_opcodes);
       current_mach = info->mach;
       opcodes_initialized = 1;
     }
 
   {
     int status =
       (*info->read_memory_func) (memaddr, buffer, sizeof (buffer), info);
 
     if (status != 0)
       {
         (*info->memory_error_func) (status, memaddr, info);
         return -1;
       }
   }
 
   /* On SPARClite variants such as DANlite (sparc86x), instructions
      are always big-endian even when the machine is in little-endian mode.  */
   if (info->endian == BFD_ENDIAN_BIG || info->mach == bfd_mach_sparc_sparclite)
     getword = bfd_getb32;
   else
     getword = bfd_getl32;
 
   insn = getword (buffer);
 
   info->insn_info_valid = 1;                    /* We do return this info.  */
   info->insn_type = dis_nonbranch;              /* Assume non branch insn.  */
   info->branch_delay_insns = 0;                 /* Assume no delay.  */
   info->target = 0;                             /* Assume no target known.  */
 
   for (op = opcode_hash_table[HASH_INSN (insn)]; op; op = op->next)
     {
       const sparc_opcode *opcode = op->opcode;
 
       /* If the insn isn't supported by the current architecture, skip it.  */
       if (! (opcode->architecture & current_arch_mask))
         continue;
 
       if ((opcode->match & insn) == opcode->match
           && (opcode->lose & insn) == 0)
         {
           /* Nonzero means that we have found an instruction which has
              the effect of adding or or'ing the imm13 field to rs1.  */
           int imm_added_to_rs1 = 0;
           int imm_ored_to_rs1 = 0;
 
           /* Nonzero means that we have found a plus sign in the args
              field of the opcode table.  */
           int found_plus = 0;
 
           /* Nonzero means we have an annulled branch.  */
           /* int is_annulled = 0; */ /* see FIXME below */
 
           /* Do we have an `add' or `or' instruction combining an
              immediate with rs1?  */
           if (opcode->match == 0x80102000) /* or */
             imm_ored_to_rs1 = 1;
           if (opcode->match == 0x80002000) /* add */
             imm_added_to_rs1 = 1;
 
           if (X_RS1 (insn) != X_RD (insn)
               && strchr (opcode->args, 'r') != NULL)
               /* Can't do simple format if source and dest are different.  */
               continue;
           if (X_RS2 (insn) != X_RD (insn)
               && strchr (opcode->args, 'O') != NULL)
               /* Can't do simple format if source and dest are different.  */
               continue;
 
           (*info->fprintf_func) (stream, "%s", opcode->name);
 
           {
             const char *s;
 
             if (opcode->args[0] != ',')
               (*info->fprintf_func) (stream, " ");
 
             for (s = opcode->args; *s != '\0'; ++s)
               {
                 while (*s == ',')
                   {
                     (*info->fprintf_func) (stream, ",");
                     ++s;
                     switch (*s)
                       {
                       case 'a':
                         (*info->fprintf_func) (stream, "a");
                         /* is_annulled = 1; */ /* see FIXME below */
                         ++s;
                         continue;
                       case 'N':
                         (*info->fprintf_func) (stream, "pn");
                         ++s;
                         continue;
 
                       case 'T':
                         (*info->fprintf_func) (stream, "pt");
                         ++s;
                         continue;
 
                       default:
                         break;
                       }
                   }
 
                 (*info->fprintf_func) (stream, " ");
 
                 switch (*s)
                   {
                   case '+':
                     found_plus = 1;
-                    /* Fall through.  */
+                    fallthrough;
 
                   default:
                     (*info->fprintf_func) (stream, "%c", *s);
                     break;
 
                   case '#':
                     (*info->fprintf_func) (stream, "0");
                     break;
 
 #define reg(n)  (*info->fprintf_func) (stream, "%%%s", reg_names[n])
                   case '1':
                   case 'r':
                     reg (X_RS1 (insn));
                     break;
 
                   case '2':
                   case 'O':
                     reg (X_RS2 (insn));
                     break;
 
                   case 'd':
                     reg (X_RD (insn));
                     break;
 #undef  reg
 
 #define freg(n)         (*info->fprintf_func) (stream, "%%%s", freg_names[n])
 #define fregx(n)        (*info->fprintf_func) (stream, "%%%s", freg_names[((n) & ~1) | (((n) & 1) << 5)])
                   case 'e':
                     freg (X_RS1 (insn));
                     break;
                   case 'v':     /* Double/even.  */
                   case 'V':     /* Quad/multiple of 4.  */
                     fregx (X_RS1 (insn));
                     break;
 
                   case 'f':
                     freg (X_RS2 (insn));
                     break;
                   case 'B':     /* Double/even.  */
                   case 'R':     /* Quad/multiple of 4.  */
                     fregx (X_RS2 (insn));
                     break;
 
                   case 'g':
                     freg (X_RD (insn));
                     break;
                   case 'H':     /* Double/even.  */
                   case 'J':     /* Quad/multiple of 4.  */
                     fregx (X_RD (insn));
                     break;
 #undef  freg
 #undef  fregx
 
 #define creg(n) (*info->fprintf_func) (stream, "%%c%u", (unsigned int) (n))
                   case 'b':
                     creg (X_RS1 (insn));
                     break;
 
                   case 'c':
                     creg (X_RS2 (insn));
                     break;
 
                   case 'D':
                     creg (X_RD (insn));
                     break;
 #undef  creg
 
                   case 'h':
                     (*info->fprintf_func) (stream, "%%hi(%#x)",
                                            ((unsigned) 0xFFFFFFFF
                                             & ((int) X_IMM22 (insn) << 10)));
                     break;
 
                   case 'i':     /* 13 bit immediate.  */
                   case 'I':     /* 11 bit immediate.  */
                   case 'j':     /* 10 bit immediate.  */
                     {
                       int imm;
 
                       if (*s == 'i')
                         imm = X_SIMM (insn, 13);
                       else if (*s == 'I')
                         imm = X_SIMM (insn, 11);
                       else
                         imm = X_SIMM (insn, 10);
 
                       /* Check to see whether we have a 1+i, and take
                          note of that fact.
 
                          Note: because of the way we sort the table,
                          we will be matching 1+i rather than i+1,
                          so it is OK to assume that i is after +,
                          not before it.  */
                       if (found_plus)
                         imm_added_to_rs1 = 1;
 
                       if (imm <= 9)
                         (*info->fprintf_func) (stream, "%d", imm);
                       else
                         (*info->fprintf_func) (stream, "%#x", imm);
                     }
                     break;
 
                   case 'X':     /* 5 bit unsigned immediate.  */
                   case 'Y':     /* 6 bit unsigned immediate.  */
                     {
                       int imm = X_IMM (insn, *s == 'X' ? 5 : 6);
 
                       if (imm <= 9)
                         (info->fprintf_func) (stream, "%d", imm);
                       else
                         (info->fprintf_func) (stream, "%#x", (unsigned) imm);
                     }
                     break;
 
                   case '3':
                     (info->fprintf_func) (stream, "%ld", X_IMM (insn, 3));
                     break;
 
                   case 'K':
                     {
                       int mask = X_MEMBAR (insn);
                       int bit = 0x40, printed_one = 0;
                       const char *name;
 
                       if (mask == 0)
                         (info->fprintf_func) (stream, "0");
                       else
                         while (bit)
                           {
                             if (mask & bit)
                               {
                                 if (printed_one)
                                   (info->fprintf_func) (stream, "|");
                                 name = sparc_decode_membar (bit);
                                 (info->fprintf_func) (stream, "%s", name);
                                 printed_one = 1;
                               }
                             bit >>= 1;
                           }
                       break;
                     }
 
                   case 'k':
                     info->target = memaddr + SEX (X_DISP16 (insn), 16) * 4;
                     (*info->print_address_func) (info->target, info);
                     break;
 
                   case 'G':
                     info->target = memaddr + SEX (X_DISP19 (insn), 19) * 4;
                     (*info->print_address_func) (info->target, info);
                     break;
 
                   case '6':
                   case '7':
                   case '8':
                   case '9':
                     (*info->fprintf_func) (stream, "%%fcc%c", *s - '6' + '0');
                     break;
 
                   case 'z':
                     (*info->fprintf_func) (stream, "%%icc");
                     break;
 
                   case 'Z':
                     (*info->fprintf_func) (stream, "%%xcc");
                     break;
 
                   case 'E':
                     (*info->fprintf_func) (stream, "%%ccr");
                     break;
 
                   case 's':
                     (*info->fprintf_func) (stream, "%%fprs");
                     break;
 
                   case 'o':
                     (*info->fprintf_func) (stream, "%%asi");
                     break;
 
                   case 'W':
                     (*info->fprintf_func) (stream, "%%tick");
                     break;
 
                   case 'P':
                     (*info->fprintf_func) (stream, "%%pc");
                     break;
 
                   case '?':
                     if (X_RS1 (insn) == 31)
                       (*info->fprintf_func) (stream, "%%ver");
                     else if ((unsigned) X_RS1 (insn) < 17)
                       (*info->fprintf_func) (stream, "%%%s",
                                              v9_priv_reg_names[X_RS1 (insn)]);
                     else
                       (*info->fprintf_func) (stream, "%%reserved");
                     break;
 
                   case '!':
                     if ((unsigned) X_RD (insn) < 17)
                       (*info->fprintf_func) (stream, "%%%s",
                                              v9_priv_reg_names[X_RD (insn)]);
                     else
                       (*info->fprintf_func) (stream, "%%reserved");
                     break;
 
                   case '$':
                     if ((unsigned) X_RS1 (insn) < 32)
                       (*info->fprintf_func) (stream, "%%%s",
                                              v9_hpriv_reg_names[X_RS1 (insn)]);
                     else
                       (*info->fprintf_func) (stream, "%%reserved");
                     break;
 
                   case '%':
                     if ((unsigned) X_RD (insn) < 32)
                       (*info->fprintf_func) (stream, "%%%s",
                                              v9_hpriv_reg_names[X_RD (insn)]);
                     else
                       (*info->fprintf_func) (stream, "%%reserved");
                     break;
 
                   case '/':
                     if (X_RS1 (insn) < 16 || X_RS1 (insn) > 25)
                       (*info->fprintf_func) (stream, "%%reserved");
                     else
                       (*info->fprintf_func) (stream, "%%%s",
                                              v9a_asr_reg_names[X_RS1 (insn)-16]);
                     break;
 
                   case '_':
                     if (X_RD (insn) < 16 || X_RD (insn) > 25)
                       (*info->fprintf_func) (stream, "%%reserved");
                     else
                       (*info->fprintf_func) (stream, "%%%s",
                                              v9a_asr_reg_names[X_RD (insn)-16]);
                     break;
 
                   case '*':
                     {
                       const char *name = sparc_decode_prefetch (X_RD (insn));
 
                       if (name)
                         (*info->fprintf_func) (stream, "%s", name);
                       else
                         (*info->fprintf_func) (stream, "%ld", X_RD (insn));
                       break;
                     }
 
                   case 'M':
                     (*info->fprintf_func) (stream, "%%asr%ld", X_RS1 (insn));
                     break;
 
                   case 'm':
                     (*info->fprintf_func) (stream, "%%asr%ld", X_RD (insn));
                     break;
 
                   case 'L':
                     info->target = memaddr + SEX (X_DISP30 (insn), 30) * 4;
                     (*info->print_address_func) (info->target, info);
                     break;
 
                   case 'n':
                     (*info->fprintf_func)
                       (stream, "%#x", SEX (X_DISP22 (insn), 22));
                     break;
 
                   case 'l':
                     info->target = memaddr + SEX (X_DISP22 (insn), 22) * 4;
                     (*info->print_address_func) (info->target, info);
                     break;
 
                   case 'A':
                     {
                       const char *name;
 
                       if ((info->mach == bfd_mach_sparc_v8plusa) ||
                           ((info->mach >= bfd_mach_sparc_v9) &&
                            (info->mach <= bfd_mach_sparc_v9b)))
                         name = sparc_decode_asi_v9 (X_ASI (insn));
                       else
                         name = sparc_decode_asi_v8 (X_ASI (insn));
 
                       if (name)
                         (*info->fprintf_func) (stream, "%s", name);
                       else
                         (*info->fprintf_func) (stream, "(%ld)", X_ASI (insn));
                       break;
                     }
 
                   case 'C':
                     (*info->fprintf_func) (stream, "%%csr");
                     break;
 
                   case 'F':
                     (*info->fprintf_func) (stream, "%%fsr");
                     break;
 
                   case 'p':
                     (*info->fprintf_func) (stream, "%%psr");
                     break;
 
                   case 'q':
                     (*info->fprintf_func) (stream, "%%fq");
                     break;
 
                   case 'Q':
                     (*info->fprintf_func) (stream, "%%cq");
                     break;
 
                   case 't':
                     (*info->fprintf_func) (stream, "%%tbr");
                     break;
 
                   case 'w':
                     (*info->fprintf_func) (stream, "%%wim");
                     break;
 
                   case 'x':
                     (*info->fprintf_func) (stream, "%ld",
                                            ((X_LDST_I (insn) << 8)
                                             + X_ASI (insn)));
                     break;
 
                   case 'y':
                     (*info->fprintf_func) (stream, "%%y");
                     break;
 
                   case 'u':
                   case 'U':
                     {
                       int val = *s == 'U' ? X_RS1 (insn) : X_RD (insn);
                       const char *name = sparc_decode_sparclet_cpreg (val);
 
                       if (name)
                         (*info->fprintf_func) (stream, "%s", name);
                       else
                         (*info->fprintf_func) (stream, "%%cpreg(%d)", val);
                       break;
                     }
                   }
               }
           }
 
           /* If we are adding or or'ing something to rs1, then
              check to see whether the previous instruction was
              a sethi to the same register as in the sethi.
              If so, attempt to print the result of the add or
              or (in this context add and or do the same thing)
              and its symbolic value.  */
           if (imm_ored_to_rs1 || imm_added_to_rs1)
             {
               unsigned long prev_insn;
               int errcode;
 
               if (memaddr >= 4)
                 errcode =
                   (*info->read_memory_func)
                   (memaddr - 4, buffer, sizeof (buffer), info);
               else
                 errcode = 1;
 
               prev_insn = getword (buffer);
 
               if (errcode == 0)
                 {
                   /* If it is a delayed branch, we need to look at the
                      instruction before the delayed branch.  This handles
                      sequences such as:
 
                      sethi %o1, %hi(_foo), %o1
                      call _printf
                      or %o1, %lo(_foo), %o1  */
 
                   if (is_delayed_branch (prev_insn))
                     {
                       if (memaddr >= 8)
                         errcode = (*info->read_memory_func)
                           (memaddr - 8, buffer, sizeof (buffer), info);
                       else
                         errcode = 1;
 
                       prev_insn = getword (buffer);
                     }
                 }
 
               /* If there was a problem reading memory, then assume
                  the previous instruction was not sethi.  */
               if (errcode == 0)
                 {
                   /* Is it sethi to the same register?  */
                   if ((prev_insn & 0xc1c00000) == 0x01000000
                       && X_RD (prev_insn) == X_RS1 (insn))
                     {
                       (*info->fprintf_func) (stream, "\t! ");
                       info->target =
                         ((unsigned) 0xFFFFFFFF
                          & ((int) X_IMM22 (prev_insn) << 10));
                       if (imm_added_to_rs1)
                         info->target += X_SIMM (insn, 13);
                       else
                         info->target |= X_SIMM (insn, 13);
                       (*info->print_address_func) (info->target, info);
                       info->insn_type = dis_dref;
                       info->data_size = 4;  /* FIXME!!! */
                     }
                 }
             }
 
           if (opcode->flags & (F_UNBR|F_CONDBR|F_JSR))
             {
                 /* FIXME -- check is_annulled flag.  */
               if (opcode->flags & F_UNBR)
                 info->insn_type = dis_branch;
               if (opcode->flags & F_CONDBR)
                 info->insn_type = dis_condbranch;
               if (opcode->flags & F_JSR)
                 info->insn_type = dis_jsr;
               if (opcode->flags & F_DELAYED)
                 info->branch_delay_insns = 1;
             }
 
           return sizeof (buffer);
         }
     }
 
   info->insn_type = dis_noninsn;        /* Mark as non-valid instruction.  */
   (*info->fprintf_func) (stream, ".long %#08lx", insn);
   return sizeof (buffer);
 }
-- 
2.39.2


